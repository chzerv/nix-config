if &filetype !=# 'cpp'
    finish
endif

" Include macros in completion
setlocal complete+=d

" Include pattern
setlocal include=^\\s*#include

" I have set path-=/usr/include so, if I'm in a cpp file, i want it back
setlocal path+=/usr/include

let b:undo_ftplugin .= '|setlocal complete< include< path<'
