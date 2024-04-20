local actions = require("telescope.actions")
local actions_layout = require("telescope.actions.layout")

require("telescope").setup({
    defaults = {
        path_display = { "truncate" },

        -- Layout config
        layout_strategy = "horizontal",
        layout_config = {
            width = 0.8,
            height = 0.65,
            preview_cutoff = 120,

            horizontal = {
                prompt_position = "top",
                preview_width = 0.55,
                results_width = 0.8,
            },
            vertical = {
                mirror = false,
            },
        },

        mappings = {
            i = {
                ["<C-x>"] = false,
                ["<C-s>"] = actions.select_horizontal,
                ["<M-p>"] = actions_layout.toggle_preview,
                ["<CR>"] = actions.select_default + actions.center,
                ["<C-Down>"] = actions.cycle_history_next,
                ["<C-Up>"] = actions.cycle_history_prev,
            },
        },

        vimgrep_arguments = {
            "rg",
            "--color=never",
            "--no-heading",
            "--with-filename",
            "--line-number",
            "--column",
            "--smart-case",
            "--hidden",
            "--trim",
            "--glob=!.git/",
        },

        file_ignore_patterns = {
            "node_modules",
            ".terraform",
            ".vagrant",
            "pycache",
            ".venv",
        },
    },

    pickers = {
        live_grep = {
            only_sort_text = true,
            path_display = { "tail" },
        },

        find_files = {
            find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
            theme = "dropdown",
            previewer = false,
        },

        git_files = {
            theme = "dropdown",
            previewer = false,
            mappings = {
                n = {
                    -- Switch to the "git status" view
                    ["gs"] = function()
                        local selection = require("telescope.actions.state").get_selected_entry()
                        require("telescope.builtin").git_status(selection)
                    end,
                },
            },
        },

        oldfiles = {
            only_cwd = true,
            theme = "dropdown",
            previewer = false,
        },

        buffers = {
            sort_mru = true,
            sort_lastused = true,
            ignore_current_buffer = true,
            theme = "dropdown",
            previewer = false,
            mappings = {
                i = {
                    ["<C-d>"] = actions.delete_buffer,
                },
            },
        },

        lsp_references = {
            show_line = false,
            -- Show the first reference at the top
            sorting_strategy = "ascending",
            layout_strategy = "vertical",
            layout_config = {
                width = 0.65,
            },
        },

        lsp_document_symbols = {
            theme = "ivy",
            previewer = false,
            -- By default, the symbol width is set to 30. As a result, in languages like Go
            -- where methods are defined as `func (svc *Service) FunctionExamle()`,
            -- the symbol names are cut off.
            symbol_width = 50,
            symbol_type_width = 50,
            ignore_symbols = { "field" }, -- Ignore "field" fields, e.g., struct fields
        },

        diagnostics = {
            sorting_strategy = "ascending",
            -- layout_strategy = "vertical",
            -- layout_config = {
            --     width = 0.65,
            -- },
        },

        help_tags = {
            theme = "ivy",
            previewer = true,
        },
    },

    extensions = {
        fzf = {
            fuzzy = true,
            override_generic_sorter = true,
            override_file_sorter = true,
            case_mode = "smart_case",
        },
        ["ui-select"] = {
            require("telescope.themes").get_dropdown({}),
        },
    },
})

require("telescope").load_extension("fzf")
require("telescope").load_extension("ui-select")

require("plugins.telescope.keymaps")
