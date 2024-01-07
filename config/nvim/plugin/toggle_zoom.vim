if exists('g:loaded_toggle_zoom')
    finish
endif
let g:loaded_toggle_zoom = 1

nnoremap <expr> <silent> <unique>
            \ <Plug>(ToggleZoom)
            \ chzerv#zoom#toggle_zoom()
