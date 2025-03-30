-- Center the cursor after scrolling or searching
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Yank/paste to/from the system clipboard
-- 'vim.opt.clipboard = "unnamedplus"' can also be set to have VIM use the system clipboard
vim.keymap.set({ "n", "x" }, "<localleader>y", [["+y"]], { desc = "Yank to the system clipboard" })
vim.keymap.set("n", "<localleader>Y", [["+Y"]], { desc = "Yank to the system clipboard" })
vim.keymap.set({ "n", "x" }, "<localleader>p", [["+p"]], { desc = "Paste from the system clipboard" })
vim.keymap.set("n", "<localleader>P", [["+P"]], { desc = "Paste from the system clipboard" })

-- Avoid clobbering yanked content when pasting in visual mode
-- ref: https://github.com/neovim/neovim/issues/19354
vim.keymap.set("x", "p", "P")
vim.keymap.set("x", "P", "p")

-- Don't yank changes
vim.keymap.set("n", "c", "\"_c")
vim.keymap.set("n", "C", "\"_C")

-- Re-select block after indenting
vim.keymap.set("x", "<", "<gv")
vim.keymap.set("x", ">", ">gv")

-- Deal with wrapped words and unnecessary jumps
vim.keymap.set("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
vim.keymap.set("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

-- Autocorrect the last spelling error
vim.keymap.set("i", "<C-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u")

-- Use ESC to turn off search highlighting
vim.keymap.set("n", "<Esc>", "<CMD>:noh<CR>")

-- Substitute the word under cursor...
vim.keymap.set(
    "n",
    "<leader>rl",
    ":s/<C-R><C-W>//g<left><left>",
    { desc = "Replace the word under the cursor, line-wise" }
)
vim.keymap.set(
    "n",
    "<leader>rb",
    ":%s/<C-R><C-W>//g<left><left>",
    { desc = "Replace the word under the cursor, buffer-wide" }
)
vim.keymap.set("x", "<leader>rv", [[:s/\%V]], { desc = "Replace the word under the cursor" })

-- "Invert" the word under cursor, e.g., true -> false
-- All credits go to: https://github.com/nguyenvukhang/nvim-toggler
vim.keymap.set("n", "!", function()
    local words = {
        ["true"] = "false",
        ["yes"] = "no",
        ["on"] = "off",
        ["present"] = "absent",
    }

    local tbl = {}

    for k, v in pairs(words) do
        tbl[k] = v
        tbl[v] = k
    end

    local cword = vim.tbl_get(tbl, vim.fn.expand("<cword>"))

    pcall(function()
        vim.cmd("norm! ciw" .. cword)
    end)
end)

-- Go to help page of the word under the cursor
vim.keymap.set("n", "gh", "yiw:help <C-R><C-W><CR>", { desc = "Help page" })

-- Search within visual selection
-- https://www.reddit.com/r/neovim/comments/zy3qq0/til_search_within_visual_selection/
vim.keymap.set("v", "/", "<esc>/\\%V")

-- Execute macro over visual selection
vim.keymap.set("x", "@", function()
    return ":norm @" .. vim.fn.getcharstr() .. "<cr>"
end, { expr = true, desc = "Execute macro over visual selection" })

-- Move lines
vim.keymap.set("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
vim.keymap.set("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })

-- Switch between windows
vim.keymap.set("n", "<A-k>", "<C-w>k", { desc = "Move to the top window" })
vim.keymap.set("n", "<A-j>", "<C-w>j", { desc = "Move to the bottom window" })
vim.keymap.set("n", "<A-h>", "<C-w>h", { desc = "Move to the left window" })
vim.keymap.set("n", "<A-l>", "<C-w>l", { desc = "Move to the right window" })

-- Resize windows using Ctrl + arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Tab navigation
vim.keymap.set("n", "[t", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "]t", ":tabnext<CR>", { desc = "Next tab" })

-- Buffer navigation
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Last buffer" })

-- Easily close the quickfix/loclist
vim.keymap.set("n", "<Bslash>q", ":cclose<CR>", { desc = "Close quickfix" })
vim.keymap.set("n", "<Bslash>l", ":lclose<CR>", { desc = "Close loclist" })

-- Command Line Bindings
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true })
