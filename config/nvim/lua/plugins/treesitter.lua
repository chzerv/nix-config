return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
        {
            "echasnovski/mini.ai",
            opts = {},
        },
        {
            "folke/ts-comments.nvim",
            opts = {},
        },
    },
    opts = {
        ensure_installed = {
            "c",
            "lua",
            "rust",
            "bash",
            "dockerfile",
            "go",
            "gomod",
            "javascript",
            "json",
            "latex",
            "python",
            "yaml",
            "fish",
            "make",
            "just",
            "hcl",
            "terraform",
            "toml",
            "html",
            "sql",
            "gitcommit",
            "diff",
            "ini",
            "vim",
            "vimdoc",
            "regex",
            "markdown",
            "markdown_inline",
            "templ",
            "nix",
            "gleam",
            "elixir",
            "heex",
        },

        highlight = {
            enable = true,
            -- Disable highlighting on files with more than 3000 lines
            disable = function(_, bufnr)
                return vim.api.nvim_buf_line_count(bufnr) > 3000
            end,
        },

        -- indent = { enable = true },

        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<M-w>",
                node_incremental = "<M-w>",
                node_decremental = "<M-C-w.",
                scope_incremental = "<M-e>",
            },
        },
    },
    config = function(_, opts)
        require("nvim-treesitter.configs").setup(opts)
    end,
}
