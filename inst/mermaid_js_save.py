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
## @deftypefn {} {ret =} mermaid_js_save (@var{graph, file_path})  
## Generate and save a diagram from a Mermaid graph description string. 
## @example
## param: graph, file_path
##
## return: ret
## @end example
##
## @end deftypefn
import sys
import base64
import io, requests
from PIL import Image as im
import matplotlib.pyplot as plt
import warnings
from builtins import UserWarning

class output(UserWarning):
    pass

def custom_warning_format(message, category, filename, lineno, file=None, line=None):
    formatted_message = f"{category.__name__}: {message}"
    print(formatted_message, end='\n')
 
# 设置自定义的警告显示处理函数
warnings.showwarning = custom_warning_format

def print_log(message, category=output, stacklevel=1, source=None):
    """Logger function. 
    1. You cannot call print() to directly print to Octave terminal.
    2. Octave package doesn't allow to make deeper Python package dir.
    So use this instead."""
    warnings.warn(message, category, stacklevel, source)

if len(sys.argv) < 3:
    sys.exit(1)

def savefig(args):
    try:
        graph = args[0]
        file_path = args[1]
        img = im.open(io.BytesIO(requests.get('https://mermaid.ink/img/' + graph).content))
        plt.imshow(img)
        plt.axis('off') # allow to hide axis
        plt.savefig(file_path, dpi=1200)
    except BaseException as e:
        print_log(e)
        return 1

if __name__ == "__main__":
    savefig(sys.argv[1:])