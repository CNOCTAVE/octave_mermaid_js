## Copyright (C) 2024-2025 Yu Hongbo <yuhongbo@member.fsf.org>, 
##                    CNOCTAVE <cnoctave@qq.com>
##
## This program is free software; you can redistribute it and/or modify it under
## the terms of the GNU General Public License as published by the Free Software
## Foundation; either version 3 of the License, or (at your option) any later
## version.
##
## This program is distributed in the hope that it will be useful, but WITHOUT
## ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
## FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more
## details.
##
## You should have received a copy of the GNU General Public License along with
## this program; if not, see <http://www.gnu.org/licenses/>.

## -*- texinfo -*-
## @deftypefn {} {[ret, status] =} mermaid_js_save (@var{graph}, @var{file_path})  
## Generate and save a diagram from a Mermaid graph description string.
##
## Since v2.0.0 the diagram is rendered locally (offline) by running the
## vendored mermaid.js bundle inside a headless Chromium -- a C++ V8 JavaScript
## runtime -- via the Node script @code{mermaid_js_render.mjs}.  No remote web
## API is contacted any more.
## @example
## param: graph, file_path
##
## return: [ret, status]
## @end example
##
## @end deftypefn
function [ret, status] = mermaid_js_save(graph, file_path)
    if nargin < 2
        print_usage();
    endif
    if (ischar(graph) != 1)
        error('Graph must be a string.');
    endif
    if (length(graph) == 0)
        error('Graph must not be empty.');
    endif
    if (ischar(file_path) != 1)
        error('File Path must be a string.');
    endif
    if (length(file_path) == 0)
        error('File Path must not be empty.');
    endif

    ret = "";
    status = -1;

    ## Locate the Node renderer shipped next to this .m file.
    me = mfilename("fullpath");
    [dir, ~, ~] = fileparts(me);
    renderer = fullfile(dir, "mermaid_js_render.mjs");

    ## Write the graph to a temp file; the renderer reads it back.  This avoids
    ## shell-quoting problems with multi-line graphs and special characters.
    graph_file = [tempname(), ".mmd"];
    fid = fopen(graph_file, "w");
    if (fid < 0)
        error('mermaid_js_save: cannot create temporary graph file.');
    endif
    fprintf(fid, "%s", graph);
    fclose(fid);

    unwind_protect
        cmd = sprintf('node "%s" "%s" "%s" default', renderer, graph_file, file_path);
        [status, output] = system(cmd);
        if (status == 0 && strncmp(output, "ok:", 3) == 1)
            ret = output;
        else
            if (status != 0)
                error('mermaid_js_save: renderer failed (status %d):\n%s', status, output);
            endif
            ret = output;
        endif
    unwind_protect_cleanup
        if (exist(graph_file, "file"))
            delete(graph_file);
        endif
    end_unwind_protect
endfunction