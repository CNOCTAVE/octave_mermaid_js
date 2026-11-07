// Copyright (C) 2024-2026 Yu Hongbo <yuhongbo@member.fsf.org>,
//                    CNOCTAVE <cnoctave@qq.com>
//
// This program is free software; you can redistribute it and/or modify it under
// the terms of the GNU General Public License as published by the Free Software
// Foundation; either version 3 of the License, or (at your option) any later
// version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
// FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
// details.
//
// You should have received a copy of the GNU General Public License along with
// this program; if not, see <http://www.gnu.org/licenses/>.

// @file mermaid_js_render.mjs
//
// New (v2.0.0) offline renderer for octave_mermaid_js.
//
// Architecture
// ------------
// mermaid.js is vendored into ./vendor/mermaid.min.js (no remote web API
// call anymore).  This script runs it inside a headless Chromium -- a C++
// implementation of the V8 JavaScript engine plus the Blink DOM/SVG layout
// engine -- which gives mermaid a real DOM and correct text measurement
// (getBBox).  The rendered SVG is then rasterized to PNG with sharp (librsvg).
//
// Usage (invoked from the Octave .m functions):
//   node mermaid_js_render.mjs <graph_file_path> <out_png_path> [theme]
//
// <graph_file_path> is a UTF-8 text file containing the Mermaid graph
// description.  Reading from a file (instead of an argument) avoids shell
// quoting problems with multi-line graphs and special characters.
//
// Exit code 0 on success, 1 on failure.

import { readFileSync } from 'fs';
import { fileURLToPath } from 'url';
import { dirname, join } from 'path';
import { createRequire } from 'module';

// Resolve puppeteer-core from the vendored Node modules that ship with the
// package (inst/vendor/node_modules).  Using an absolute path keeps the
// renderer self-contained: no global `npm install` or NODE_PATH is required at
// runtime, and it works both from the source tree and from the installed
// Octave package (Octave flattens inst/ to the package root on install, so the
// relative location of vendor/ is identical in both layouts).
const require = createRequire(import.meta.url);
const here = dirname(fileURLToPath(import.meta.url));
const puppeteer = require(join(here, 'vendor', 'node_modules', 'puppeteer-core'));

function fail(msg) {
  // Mirror the logging convention used by mermaid_js_save.py: emit a single
  // line to stdout that Octave can surface, then exit non-zero.
  process.stdout.write(String(msg) + '\n');
  process.exit(1);
}

if (process.argv.length < 4) {
  fail('usage: node mermaid_js_render.mjs <graph_file_path> <out_png_path> [theme]');
}

const graphFile = process.argv[2];
const outPath = process.argv[3];
const theme = process.argv[4] || 'default';

let graph;
try {
  graph = readFileSync(graphFile, 'utf8');
} catch (e) {
  fail('failed to read graph file "' + graphFile + '": ' + e);
}

// ---------------------------------------------------------------------------
// Locate a Chromium / Chrome executable.  The build is allowed to override via
// CHROMIUM_PATH; otherwise we probe a few well-known locations.
// ---------------------------------------------------------------------------
function findChromium() {
  if (process.env.CHROMIUM_PATH) return process.env.CHROMIUM_PATH;
  const candidates = [
    '/usr/lib64/chromium-browser/headless_shell',
    '/usr/lib64/chromium-browser/chromium-browser',
    '/usr/bin/chromium-headless',
    '/usr/bin/chromium',
    '/usr/bin/chromium-browser',
    '/usr/bin/google-chrome',
    '/usr/bin/google-chrome-stable',
  ];
  for (const c of candidates) {
    try {
      if (readFileSync(c)) return c;
    } catch (e) {
      /* not present */
    }
  }
  return null;
}

const chromiumPath = findChromium();
if (!chromiumPath) {
  fail('chromium/chrome executable not found; set CHROMIUM_PATH. ' +
       'The new architecture renders mermaid with a headless browser.');
}

// ---------------------------------------------------------------------------
// Render the diagram in headless Chromium.  Chromium (C++ V8 + Blink) provides
// a real DOM and correct text measurement, so the layout is accurate.  The same
// engine also rasterizes the result to PNG via a screenshot, which guarantees
// that text is rendered with the system fonts (unlike a standalone SVG
// rasterizer, whose font resolution can be unreliable in minimal containers).
// ---------------------------------------------------------------------------
let browser;
try {
  browser = await puppeteer.launch({
    executablePath: chromiumPath,
    headless: 'shell',
    args: [
      '--no-sandbox',
      '--disable-gpu',
      '--disable-dev-shm-usage',
      '--disable-software-rasterizer',
    ],
  });
} catch (e) {
  fail('failed to launch chromium: ' + (e && e.message ? e.message : e));
}

try {
  const page = await browser.newPage();
  await page.setContent(
    '<!DOCTYPE html><html><head><meta charset="utf-8"></head><body></body></html>'
  );
  // Load the vendored mermaid bundle into the page (sets window.mermaid).
  await page.addScriptTag({
    path: join(here, 'vendor', 'mermaid.min.js'),
  });

  // Render and inject the SVG into the page, then measure its real pixel size.
  const dims = await page.evaluate(
    async (g, t) => {
      const m = window.mermaid;
      if (!m || typeof m.render !== 'function') {
        throw new Error('vendored mermaid failed to initialize');
      }
      m.initialize({ startOnLoad: false, theme: t, securityLevel: 'loose' });
      const id = 'mermaid-' + Date.now() + '-' + Math.floor(Math.random() * 1e6);
      const result = await m.render(id, g);
      const svg = typeof result === 'string' ? result : result.svg;
      document.body.innerHTML = '';
      const wrap = document.createElement('div');
      wrap.innerHTML = svg;
      document.body.appendChild(wrap);
      const svgEl = wrap.querySelector('svg');
      const vb = (svgEl.getAttribute('viewBox') || '0 0 100 100')
        .split(/[\s,]+/)
        .map(Number);
      svgEl.setAttribute('width', String(vb[2]));
      svgEl.setAttribute('height', String(vb[3]));
      const r = svgEl.getBoundingClientRect();
      return {
        w: Math.max(1, Math.ceil(r.width)),
        h: Math.max(1, Math.ceil(r.height)),
      };
    },
    graph,
    theme
  );

  // Screenshot the page at high device scale factor for a crisp PNG.
  await page.setViewport({
    width: dims.w,
    height: dims.h,
    deviceScaleFactor: 3,
  });
  await page.screenshot({ path: outPath, fullPage: true, type: 'png' });
  await browser.close();
} catch (e) {
  if (browser) {
    try { await browser.close(); } catch (e2) { /* ignore */ }
  }
  fail('mermaid rendering failed: ' + (e && e.message ? e.message : e));
}

process.stdout.write('ok:' + outPath + '\n');
process.exit(0);
