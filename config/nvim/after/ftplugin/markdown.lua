vim.opt_local.spell = true
vim.opt_local.spelllang = "en_us"
vim.opt_local.foldlevel = 1
vim.opt_local.conceallevel = 2
vim.opt_local.formatoptions:append("t")

vim.g.vim_markdown_folding_disabled = false
vim.g.vim_markdown_folding_style_pythonic = 1
vim.g.vim_markdown_conceal = false
vim.g.vim_markdown_conceal_code_blocks = false
vim.g.vim_markdown_frontmatter = true
vim.g.vim_markdown_toml_frontmatter = false
vim.g.vim_markdown_json_frontmatter = false
vim.g.vim_markdown_no_extensions_in_markdown = false
vim.g.vim_markdown_follow_anchor = true
vim.g.vim_markdown_new_list_item_indent = 2

vim.b.minisurround_config = {
    custom_surroundings = {
        -- Bold
        b = {
            output = { left = "**", right = "**" },
        },

        -- Italics
        i = {
            output = { left = "*", right = "*" },
        },

        -- Surround word with link from the clipboard
        l = {
            output = function()
                local clipboard = vim.fn.getreg("+"):gsub("\n", "")
                return { left = "[", right = "](" .. clipboard .. ")" }
            end,
        },

        -- Surround visual selection with a code block of a user specified language
        c = {
            output = function()
                local lang = MiniSurround.user_input("Enter code block language: ") or ""
                return { left = "```" .. lang .. "\n", right = "\n```" }
            end,
        },
    },
}
