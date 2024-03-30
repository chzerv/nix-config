-- Seamless navigation between tmux and neovim
return {
    "christoomey/vim-tmux-navigator",
    cmd = {
        "TmuxNavigateLeft",
        "TmuxNavigateDown",
        "TmuxNavigateUp",
        "TmuxNavigateRight",
        "TmuxNavigatePrevious",
    },
    keys = {
        { "<A-h>", "<cmd>TmuxNavigateLeft<cr>" },
        { "<A-j>", "<cmd>TmuxNavigateDown<cr>" },
        { "<A-k>", "<cmd>TmuxNavigateUp<cr>" },
        { "<A-l>", "<cmd>TmuxNavigateRight<cr>" },
        { "<A-\\>", "<cmd>TmuxNavigatePrevious<cr>" },
    },
    init = function()
        vim.g.tmux_navigator_no_mappings = 1
        -- Fixes an issue where moving out of (Neo)vim is very slow. See the linked comment:
        -- https://github.com/christoomey/vim-tmux-navigator/issues/72#issuecomment-103578088
        vim.opt.shell = "/usr/bin/env bash -i"
    end,
}
