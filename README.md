# octave_mermaid_js
 The octave_mermaid_js package is used to 
 create diagrams and visualizations using Mermaid.js 
 within GNU Octave.

# Runtime requirements (since v2.0.0)
 Starting with v2.0.0 the diagrams are rendered locally and offline. The
 package vendors mermaid.js (./inst/vendor/mermaid.min.js) and runs it inside a
 headless Chromium (a C++ V8 JavaScript runtime with the Blink DOM/SVG layout
 engine) via the bundled Node.js script inst/mermaid_js_render.mjs. There is no
 remote web API call any more.
 You need:
 1. Node.js (provides the V8 JavaScript runtime used to drive the renderer).
 2. A Chromium/Chrome browser for headless rendering. If it is not on a standard
    path, set the CHROMIUM_PATH environment variable to its executable.
 On Fedora you can install both with: `sudo dnf install nodejs chromium-headless`.
 The Node dependency puppeteer-core is vendored under inst/vendor/node_modules,
 so no separate `npm install` is required after `pkg install`.
# octave_mermaid_js Document
 Check out document: [octave_mermaid_js Document](https://cnoctave.github.io/octave_mermaid_js/index.html)
# How to translate octave_mermaid_js Document into another language
 In ./docs directory, index.html is zh-CN simplified Chinese document. 
 For example, if you want to translate document into English.
 1. Copy index.html as another document with different language code as filename, 
 for example, en-US.html.
 2. Translate en-US.html into English.
 3. Add dropdown like the picture below to every *.html. 
 For example, add dropdown "en-US English".  
 ![the dropdown looking](./docs/translate_dropdown.png)  
 The code for adding dropdown is like the picture below.  
 ![the dropdown code](./docs/translate_dropdown_code.png) 
 4. PR to octave_mermaid_js.