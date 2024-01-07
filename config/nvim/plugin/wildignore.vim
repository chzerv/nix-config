" Below is a list of filetypes to be ignored when using
" find commands

if &compatible || !has('wildignore')
    finish
endif
if exists('g:loaded_wildmenu')
    finish
endif

let g:loaded_wildmenu = 1

function! s:Wildignore() abort

    let l:ignores = []

    " Archives 
    let l:ignores += [
                \ '*.7z'
                \,'*bz2'
                \,'*.gz'
                \,'*.rar'
                \,'*tar'
                \,'*xz'
                \,'*zip'
                \ ]

    " Documents
    let l:ignores+= [
                \ '*.docs'
                \,'*.djvu'
                \,'*.odp'
                \,'*.ods'
                \,'*.odt'
                \,'*.pdf'
                \,'*.ppt'
                \,'*.xls'
                \,'*.xlsx'
                \ ]

    " Executables
    let l:ignores+= [
                \ '*.exe'
                \ ]

    " Images, music and video
    let l:ignores += [
            \ '*.bmp'
            \,'*.gd2'
            \,'*.gif'
            \,'*.ico'
            \,'*.jpeg'
            \,'*.jpg'
            \,'*.pbm'
            \,'*.png'
            \,'*.psd'
            \,'*.tga'
            \,'*.xbm'
            \,'*.xcf'
            \,'*.xpm'
            \,'*.au'
            \,'*.aup'
            \,'*.flac'
            \,'*.mid'
            \,'*.m4a'
            \,'*.mp3'
            \,'*.ogg'
            \,'*.opus'
            \,'*.s3m'
            \,'*.wav'
            \,'*.avi'
            \,'*.gifv'
            \,'*.mp4'
            \,'*.ogv'
            \,'*.rm'
            \,'*.swf'
            \,'*.webm'
            \ ]

    " Versioning
    let l:ignores += [
                \ '.git'
                \,'.hg'
                \,'.svn'
                \ ]

    return join(l:ignores, ',')

endfunction

" Run the abobe function just defined.
let &wildignore = s:Wildignore()
