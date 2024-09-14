-- Center the cursor after scrolling down/up
vim.keymap.set("n", "<C-d>", "<C-d>M")
vim.keymap.set("n", "<C-u>", "<C-u>M")

-- Center the cursor and open folds when navigating through search matches
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

-- Put blank lines below/above current line
vim.keymap.set(
    "n",
    "[<Space>",
    "<CMD>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<CR>",
    { desc = "Put a blank line above the cursor" }
)
vim.keymap.set(
    "n",
    "]<Space>",
    "<CMD>put =repeat(nr2char(10), v:count1) <Bar> '[-1<CR>",
    { desc = "Put a blank line below the cursor" }
)

-- Spellcheck
-- The blank string in the mode indicates that this is a 'map' mapping
vim.keymap.set("", "<F6>", "<Cmd>setlocal spell! spelllang=en_us<CR>", { desc = "Toggle spell check for English" })
vim.keymap.set("", "<F7>", "<Cmd>setlocal spell! spelllang=el<CR>", { desc = "Toggle spell check for Greek" })
vim.keymap.set(
    "",
    "<F8>",
    "<Cmd>setlocal spell! spelllang=en_us,el<CR>",
    { desc = "Toggle spell check for English+Greek" }
)

-- Autocorrect the last spelling error
vim.keymap.set("i", "<C-f>", "<c-g>u<Esc>[s1z=`]a<c-g>u")

-- Use ESC to turn off search highlighting
vim.keymap.set("n", "<Esc>", "<CMD>:noh<CR>")

-- Substitute the word under cursor...
vim.keymap.set(
    "n",
    "<leader>rl",
    ":s/<C-R><C-W>//g<left><left>",
    { desc = "Rename the word under the cursor, line-wise" }
)
vim.keymap.set(
    "n",
    "<leader>rb",
    ":%s/<C-R><C-W>//g<left><left>",
    { desc = "Rename the word under the cursor, buffer-wide" }
)
vim.keymap.set("x", "<leader>rv", [[:s/\%V]], { desc = "Rename the word under the cursor" })

-- "Invert" the word under cursor, e.g., true -> false
vim.keymap.set("n", "!", "<cmd>lua require'custom.invert-text'.invert()<cr>")

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
vim.keymap.set("n", "<left>", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "<right>", ":tabnext<CR>", { desc = "Next tab" })

-- Buffer navigation
vim.keymap.set("n", "[b", ":bprevious<CR>", { desc = "Previous buffer" })
vim.keymap.set("n", "]b", ":bnext<CR>", { desc = "Next buffer" })
vim.keymap.set("n", "<leader><leader>", "<c-^>", { desc = "Last buffer" })

-- Quickfix navigation
vim.keymap.set("n", "[q", ":cprevious<CR>", { desc = "Previous quickfix item" })
vim.keymap.set("n", "]q", ":cnext<CR>", { desc = "Next quickfix item" })
vim.keymap.set("n", "<Bslash>q", ":cclose<CR>", { desc = "Close quickfix" })

-- Location list navigation
vim.keymap.set("n", "[l", ":lprevious<CR>", { desc = "Previous loclist item" })
vim.keymap.set("n", "]l", ":lnext<CR>", { desc = "Next loclist item" })
vim.keymap.set("n", "<Bslash>l", ":lclose<CR>", { desc = "Close loclist" })

-- Neovim Terminal
vim.keymap.set(
    "n",
    "<leader>tt",
    [[<cmd>lua require'custom.term'.toggle_term("split", 15)<cr>]],
    { desc = "Toggle terminal" }
)
vim.keymap.set(
    "t",
    "<leader>tt",
    "<C-\\><C-n><cmd>lua require'custom.term'.toggle_term('split', 15)<cr>",
    { desc = "Toggle terminal" }
)
vim.keymap.set(
    "n",
    "<leader>tT",
    "<cmd>lua require'custom.term'.launch_term_in_tab()<cr>",
    { desc = "Open terminal in new tab" }
)

vim.keymap.set(
    "n",
    "<leader>ts",
    "<cmd>lua require'custom.term'.send_line_to_term()<cr>",
    { desc = "Send current line to terminal" }
)
vim.keymap.set(
    "v",
    "<leader>ts",
    "<cmd>lua require'custom.term'.send_visual_to_term()<cr>",
    { desc = "Send visual selection to terminal" }
)

vim.keymap.set("t", "[t", "<C-\\><C-n><cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("t", "]t", "<C-\\><C-n><cmd>tabnext<CR>", { desc = "Next tab" })

vim.keymap.set("t", "<A-[>", "<C-\\><C-n>")
vim.keymap.set("t", "<A-k>", "<C-\\><C-n><C-w>k")
vim.keymap.set("t", "<A-j>", "<C-\\><C-n><C-w>j")
vim.keymap.set("t", "<A-h>", "<C-\\><C-n><C-w>h")
vim.keymap.set("t", "<A-l>", "<C-\\><C-n><C-w>l")

-- Command Line Bindings
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true })
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true })
