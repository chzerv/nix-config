----------------------------------------------
-- Configuration for treesitter
-- https://github.com/nvim-treesitter/nvim-treesitter
----------------------------------------------

return {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufReadPost",
    dependencies = {
        "nvim-treesitter/nvim-treesitter-textobjects",
    },
    config = function()
        local ts = require("nvim-treesitter.configs")

        ts.setup({
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
                "markdown",
                "markdown_inline",
                "templ",
                "nix",
                "gleam",
            },
            sync_install = false,
            ignore_install = {},
            highlight = {
                enable = true,
                -- Disable TS highlighting on large files or files with very long lines
                disable = function(_, bufnr)
                    return vim.api.nvim_buf_line_count(bufnr) > 5000
                        or vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1]:len() > 500
                end,
                additional_vim_regex_highlighting = false,
            },
            indent = {
                enable = true,
            },
            -- nvim-treesitter/nvim-treesitter-textobjects
            textobjects = {
                select = {
                    enable = true,
                    lookahead = true,
                    keymaps = {
                        ["af"] = "@function.outer",
                        ["if"] = "@function.inner",
                        ["ac"] = "@class.outer",
                        ["ic"] = "@class.inner",
                        ["al"] = "@loop.outer",
                        ["il"] = "@loop.inner",
                        ["aa"] = "@parameter.outer",
                        ["ia"] = "@parameter.inner",
                        ["uc"] = "@comment.outer",
                    },
                },
                move = {
                    enable = true,
                    set_jumps = true, -- Set jumps in the jumplist
                    goto_next_start = {
                        ["]m"] = "@function.outer",
                        ["]]"] = "@class.outer",
                    },
                    goto_next_end = {
                        ["]M"] = "@function.outer",
                        ["]["] = "@class.outer",
                    },
                    goto_previous_start = {
                        ["[m"] = "@function.outer",
                        ["[["] = "@class.outer",
                    },
                    goto_previous_end = {
                        ["[M"] = "@function.outer",
                        ["[]"] = "@class.outer",
                    },
                },
                swap = {
                    enable = true,
                    swap_next = { ["<Leader>rx"] = "@parameter.inner" },
                    swap_previous = { ["<Leader>rX"] = "@parameter.inner" },
                },
            },
            incremental_selection = {
                enable = true,
                keymaps = {
                    init_selection = "<M-w>",
                    node_incremental = "<M-w>",
                    node_decremental = "<M-C-w.",
                    scope_incremental = "<M-e>",
                },
            },
        })
    end,
}
