local U = {}

-- https://www.reddit.com/r/neovim/comments/pg1o6k/neovim_lsp_hover_window_is_hidden_behind_line/
function U.fix_buf_hover()
    vim.o.eventignore = "CursorHold"
    vim.lsp.buf.hover()
    vim.cmd([[autocmd CursorMoved <buffer> ++once set eventignore=""]])
end

return U
