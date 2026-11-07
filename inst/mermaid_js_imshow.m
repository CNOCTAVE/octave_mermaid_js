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
## @deftypefn {} {[ret, status] =} mermaid_js_imshow (@var{graph})  
## Generate and display a diagram from a Mermaid graph description string.
##
## Since v2.0.0 the diagram is rendered locally (offline) by running the
## vendored mermaid.js bundle inside a headless Chromium -- a C++ V8 JavaScript
## runtime -- via the Node script @code{mermaid_js_render.mjs}.  No remote web
## API is contacted any more.
## @example
## param: graph
##
## return: [ret, status]
## @end example
##
## @end deftypefn
function [ret, status] = mermaid_js_imshow(graph)
    if nargin < 1
        print_usage();
    endif
    if (ischar(graph) != 1)
        error('Graph must be a string.');
    endif
    if (length(graph) == 0)
        error('Graph must not be empty.');
    endif
    ret = "";
    status = -1;
    file_path = [tempname(), ".png"];
    [ret, status] = mermaid_js_save(graph, file_path);
    imshow(file_path);
    unwind_protect
        disp("cleaning up temporary file...");
    unwind_protect_cleanup
        if (exist(file_path, "file"))
            delete(file_path);
        endif
    end_unwind_protect
endfunction