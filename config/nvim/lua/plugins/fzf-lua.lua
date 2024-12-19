return {
    "ibhagwan/fzf-lua",
    cmd = "FzfLua",
    dependencies = {
        {
            "echasnovski/mini.icons",
            opts = {},
        },
    },
    keys = {
        { "<leader>ff", "<cmd>FzfLua files<cr>", desc = "Find files" },

        {
            "<leader>fF",
            function()
                local dir_to_search
                local _ = vim.ui.input({ prompt = "Find files in > ", completion = "dir" }, function(input)
                    dir_to_search = input
                end)

                require("fzf-lua").files({ cwd = dir_to_search })
            end,
            desc = "Find files in dir",
        },

        { "<leader>fo", "<cmd>FzfLua oldfiles<cr>", desc = "Find oldfiles" },
        { "<leader>fh", "<cmd>FzfLua help_tags<cr>", desc = "Helptags" },

        { "<leader>fg", "<cmd>FzfLua live_grep_glob<cr>", desc = "Grep" },
        { "<leader>fg", "<cmd>FzfLua grep_visual<cr>", desc = "Grep", mode = "x" },

        {
            "<leader>fb",
            function()
                require("fzf-lua").lgrep_curbuf({
                    winopts = {
                        height = 0.6,
                        width = 0.8,
                        preview = { vertical = "down:65%" },
                    },
                })
            end,
            desc = "Grep current buffer",
        },
        { "<leader>fw", "<cmd>FzfLua grep_cword<cr>", desc = "Grep word under cursor" },

        { "<leader>,", "<cmd>FzfLua buffers<cr>", desc = "Buffers" },
    },
    opts = function()
        local actions = require("fzf-lua.actions")

        return {
            global_git_icons = false,

            winopts = {
                height = 0.6,
                width = 0.55,
                preview = {
                    scrollbar = false,
                    layout = "vertical",
                    vertical = "down:40%",
                    default = "bat_native",
                },
            },

            fzf_colors = true,

            -- Options to be passed to FZF
            fzf_opts = {
                ["--cycle"] = true, -- Let selection start over once it reaches the end
            },

            -- Use telescope-like mappings
            -- https://github.com/ibhagwan/fzf-lua/blob/main/lua/fzf-lua/profiles/telescope.lua#L56
            keymap = {
                builtin = {
                    -- Only valid with the builtin previewer
                    ["<A-p>"] = "toggle-preview",

                    ["<F1>"] = "toggle-help",
                    ["<C-d>"] = "preview-page-down",
                    ["<C-u>"] = "preview-page-up",
                },

                fzf = {
                    -- Only valid with fzf previewers (bat/cat/git/etc)
                    ["alt-p"] = "toggle-preview",

                    ["ctrl-z"] = "abort",
                    ["ctrl-f"] = "half-page-down",
                    ["ctrl-b"] = "half-page-up",
                    ["ctrl-a"] = "beginning-of-line",
                    ["ctrl-e"] = "end-of-line",
                    ["alt-a"] = "toggle-all",
                    ["ctrl-d"] = "preview-page-down",
                    ["ctrl-u"] = "preview-page-up",
                    ["ctrl-q"] = "select-all+accept",
                },
            },

            -- https://github.com/ibhagwan/fzf-lua/wiki/Options#provider-options
            files = {
                winopts = {
                    preview = { hidden = "hidden" },
                },
                formatter = "path.filename_first",
            },

            oldfiles = {
                winopts = {
                    preview = { hidden = "hidden" },
                },
            },

            buffers = {
                ignore_current_buffer = true,
                cwd_only = true,
                sort_lastused = true,
            },

            lsp = {
                code_actions = {
                    previewer = vim.fn.executable("delta") == 1 and "codeaction_native" or nil,
                },
            },

            require("fzf-lua").register_ui_select(),
        }
    end,
}
