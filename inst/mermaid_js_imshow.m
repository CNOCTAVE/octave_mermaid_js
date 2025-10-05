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
    [ret, status] = python("mermaid_js_save.py", matlab.net.base64encode(graph), file_path);
    imshow(file_path);
    unwind_protect
        disp("cleaning up temporary file...");
    unwind_protect_cleanup
        delete(file_path);
    end_unwind_protect
endfunction