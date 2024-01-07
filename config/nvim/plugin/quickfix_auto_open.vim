" Original author: https://github.com/romainl

if exists('g:loaded_quickfix_auto_open') 
    finish
endif

if !exists('##QuickfixCmdPost') || !exists('##VimEnter')
    finish
endif
let g:loaded_quickfix_auto_open = 1

augroup QuickfixAutoOpen
    autocmd!
    autocmd QuickfixCmdPost [^l]* cwindow
    autocmd QuickfixCmdPost l* lwindow
    autocmd VimEnter * cwindow
augroup END
