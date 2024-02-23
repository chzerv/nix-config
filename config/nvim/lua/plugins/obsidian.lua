return {
    "epwalsh/obsidian.nvim",
    version = "*",
    lazy = true,
    -- Load the plugin only when inside an Obsidian vault
    event = {
        "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Syncthing/Obsidian_Vault/**.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Syncthing/Obsidian_Vault/**.md",
        "BufReadPre " .. vim.fn.expand("~") .. "/Documents/Syncthing/Notes/**.md",
        "BufNewFile " .. vim.fn.expand("~") .. "/Documents/Syncthing/Notes/**.md",
    },
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    keys = {
        { "<leader>oq", "<cmd>ObsidianQuickSwitch<CR>" },
        { "<leader>ot", "<cmd>ObsidianTags<CR>" },
        { "<leader>os", "<cmd>ObsidianSearch<CR>" },
        { "<leader>ob", "<cmd>ObsidianBacklinks<CR>" },
        { "<leader>ol", "<cmd>ObsidianLinks<CR>" },
    },
    opts = {
        workspaces = {
            {
                name = "vault",
                path = "~/Documents/Syncthing/Obsidian_Vault",
            },
            {
                name = "notes",
                path = "~/Documents/Syncthing/Notes",
            },
        },

        mappings = {
            ["<leader>oq"] = {
                action = ":ObsidianQuickSwitch<CR>",
                opts = { buffer = true },
            },
            ["<leader>st"] = {
                action = ":ObsidianTags<CR>",
                opts = { buffer = true },
            },
            ["gf"] = {
                action = function()
                    return require("obsidian").util.gf_passthrough()
                end,
                opts = { noremap = false, expr = true, buffer = true },
            },
        },
    },
}
