-- Credits to MariaSolOs: https://github.com/MariaSolOs/dotfiles/blob/main/.config/nvim/lua/commands.lua
vim.api.nvim_create_user_command("ToggleInlayHints", function()
    vim.g.inlay_hints = not vim.g.inlay_hints
    vim.notify(string.format("%s inlay hints...", vim.g.inlay_hints and "Enabling" or "Disabling"), vim.log.levels.INFO)

    local mode = vim.api.nvim_get_mode().mode
    vim.lsp.inlay_hint.enable(vim.g.inlay_hints and (mode == "n" or mode == "v"))
end, { desc = "Toggle inlay hints", nargs = 0 })
