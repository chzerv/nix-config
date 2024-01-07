if &filetype !=# 'sh'
    finish
endif

augroup SH
    autocmd! * <buffer>
    au BufWinEnter <buffer> setlocal makeprg=shellcheck\ -f\ gcc\ %
    au BufWritePost <buffer> silent make! <afile> | silent redraw!
augroup END

let b:undo_ftplugin = get(b:, 'undo_ftplugin', '')
            \ .(empty(get(b:, 'undo_ftplugin', '')) ? '' : '|') 
            \ ."
            \| exe 'au! SH * <buffer>'
            \"

