if &filetype !=# 'vim'
    finish
endif

setlocal keywordprg=:help
setlocal foldmethod=marker
setlocal omnifunc=syntaxcomplete#Complete

let b:undo_ftplugin .= '|setlocal keywordprg< foldmethod<'
