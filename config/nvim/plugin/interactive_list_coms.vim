function! <sid>CCR()
    if getcmdtype() isnot# ':'
      return "\<CR>"
    endif
    let cmdline = getcmdline()
    if cmdline =~# '\v^\s*(ls|files|buffers)!?\s*(\s[+\-=auhx%#]+)?$'
        " like :ls but prompts for a buffer command
        return "\<CR>:b"
    elseif cmdline =~# '\v/(#|nu%[mber])$'
        " like :g//# but prompts for a command
        return "\<CR>:"
    elseif cmdline =~# '\v^\s*(dli%[st]|il%[ist])!?\s+\S'
        " like :dlist or :ilist but prompts for a count for :djump or :ijump
        return "\<CR>:" . cmdline[0] . "j  " . split(cmdline, " ")[1] . "\<S-Left>\<Left>"
    elseif cmdline =~# '\v^\s*(cli|lli)%[st]!?\s*(\s\d+(,\s*\d+)?)?$'
        " like :clist or :llist but prompts for an error/location number
        return "\<CR>:sil " . repeat(cmdline[0], 2) . "\<Space>"
    elseif cmdline =~# '\v^\s*ol%[dfiles]\s*$'
        " like :oldfiles but prompts for an old file to edit
        set nomore
        return "\<CR>:sil se more|e #<"
    elseif cmdline =~# '^\s*changes\s*$'
        " like :changes but prompts for a change to jump to
        set nomore
        return "\<CR>:sil se more|norm! g;\<S-Left>"
    elseif cmdline =~# '\v^\s*ju%[mps]'
        " like :jumps but prompts for a position to jump to
        set nomore
        return "\<CR>:sil se more|norm! \<C-o>\<S-Left>"
    elseif cmdline =~ '\v^\s*marks\s*(\s\w+)?$'
        " like :marks but prompts for a mark to jump to
        return "\<CR>:norm! `"
    elseif cmdline =~# '\v^\s*undol%[ist]'
        " like :undolist but prompts for a change to undo
        return "\<CR>:u "
    else
        return "\<c-]>\<CR>"
    endif
endfunction

cnoremap <expr> <CR> <sid>CCR()
