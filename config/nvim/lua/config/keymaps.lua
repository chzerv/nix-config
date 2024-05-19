local map = function(mode, lhs, rhs, opts)
    local default_opts = { noremap = true, silent = true }

    opts = vim.tbl_deep_extend("force", opts or {}, default_opts)

    vim.keymap.set(mode, lhs, rhs, opts)
end

-- Set <space> as the leader key
vim.g.mapleader = " "

-- Set <\\> as the localleader key
vim.g.maplocalleader = "\\"

-- Center the cursor after scrolling down/up
map("n", "<C-d>", "<C-d>M")
map("n", "<C-u>", "<C-u>M")

-- Center the cursor and open folds when navigating through search matches
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Yank/paste to/from the system clipboard
-- 'vim.opt.clipboard = "unnamedplus"' can also be set to have VIM use the system clipboard
map({ "n", "x" }, "<leader>y", [["+y"]])
map("n", "<leader>Y", [["+Y"]])
map({ "n", "x" }, "<leader>p", [["+p"]])
map("n", "<leader>P", [["+P"]])

-- Avoid clobbering yanked content when pasting in visual mode
-- ref: https://github.com/neovim/neovim/issues/19354
map("x", "p", "P")
map("x", "P", "p")

-- Don't yank changes
map("n", "c", "\"_c")
map("n", "C", "\"_C")

-- Delete without yanking
map({ "n", "x" }, "<leader>d", "\"_d")

-- Re-select block after indenting
map("x", "<", "<gv")
map("x", ">", ">gv")

-- Allow moving through wrapped lines
map("n", "k", "gk")
map("n", "j", "gj")
map("n", "gk", "k")
map("n", "gj", "j")

-- Put blank lines below/above current line
map("n", "[<Space>", "<CMD>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<CR>", { desc = "Put a blank line above the cursor" })
map("n", "]<Space>", "<CMD>put =repeat(nr2char(10), v:count1) <Bar> '[-1<CR>", { desc = "Put a blank line below the cursor" })

-- Toggle spellcheck
-- The blank string in the mode indicates that this is a 'map' mapping
map("", "<F6>", "<Cmd>setlocal spell! spelllang=en_us<CR>")
map("", "<F7>", "<Cmd>setlocal spell! spelllang=el<CR>")
map("", "<F8>", "<Cmd>setlocal spell! spelllang=en_us,el<CR>")

-- Autocorrect the last spelling error
map("i", "<C-s>", "<c-g>u<Esc>[s1z=`]a<c-g>u")

-- Use ESC to turn off search highlighting
map("n", "<Esc>", "<CMD>:noh<CR>")

-- Substitute the word under cursor...
map("n", "<leader>rl", ":s/<C-R><C-W>//g<left><left>") -- line wise
map("n", "<leader>rb", ":%s/<C-R><C-W>//g<left><left>") -- buffer wise

-- Substitution in visual selection
map("x", "<leader>rv", [[:s/\%V]])

-- "Invert" the word under cursor, e.g., true -> false
map("n", "!", "<cmd>lua require'custom.invert-text'.invert()<cr>")

-- Go to help page of the word under the cursor
map("n", "gh", "yiw:help <C-R><C-W><CR>")

-- Search within visual selection
-- https://www.reddit.com/r/neovim/comments/zy3qq0/til_search_within_visual_selection/
map("v", "/", "<esc>/\\%V")

-- Execute macro over visual selection
map('x', '@', function()
    return ':norm @' .. vim.fn.getcharstr() .. '<cr>'
end, { expr = true, desc = "Execute macro over visual selection" })

-- Move lines
map("n", "<C-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("n", "<C-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("v", "<C-k>", ":m '<-2<cr>gv=gv", { desc = "Move line up" })
map("v", "<C-j>", ":m '>+1<cr>gv=gv", { desc = "Move line down" })

-- Switch between windows
map('n', '<A-k>', '<C-w>k', { desc = 'Move to the top window'})
map('n', '<A-j>', '<C-w>j', { desc = 'Move to the bottom window'})
map('n', '<A-h>', '<C-w>h', { desc = 'Move to the left window'})
map('n', '<A-l>', '<C-w>l', { desc = 'Move to the right window'})

-- Resize windows using Ctrl + arrow keys
map("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
map("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
map("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Tab navigation
map("n", "[t", ":tabprevious<CR>")
map("n", "]t", ":tabnext<CR>")
map("n", "<left>", ":tabprevious<CR>")
map("n", "<right>", ":tabnext<CR>")

-- Buffer navigation
map("n", "[b", ":bprevious<CR>")
map("n", "]b", ":bnext<CR>")
map("n", "<leader><leader>", "<c-^>")

-- Quickfix navigation
map("n", "[q", ":cprevious<CR>")
map("n", "]q", ":cnext<CR>")
map("n", "]Q", ":cfirst<CR>")
map("n", "[Q", ":clast<CR>")
map("n", "<Bslash>q", ":cclose<CR>")

-- Location list navigation
map("n", "[l", ":lprevious<CR>")
map("n", "]l", ":lnext<CR>")
map("n", "]L", ":lfirst<CR>")
map("n", "[L", ":llast<CR>")
map("n", "<Bslash>l", ":lclose<CR>")

-- Neovim Terminal
map("n", "<C-\\>", [[<cmd>lua require'custom.term'.toggle_term("split", 15)<cr>]])
map("t", "<C-\\>", "<C-\\><C-n><cmd>lua require'custom.term'.toggle_term('split', 15)<cr>")
map("n", "<leader>tt", "<cmd>lua require'custom.term'.launch_term_in_tab()<cr>")

map("n", "<leader>ts", "<cmd>lua require'custom.term'.send_line_to_term()<cr>")
map("v", "<leader>ts", "<cmd>lua require'custom.term'.send_visual_to_term()<cr>")

map("t", "[t", "<C-\\><C-n><cmd>tabprevious<CR>")
map("t", "]t", "<C-\\><C-n><cmd>tabnext<CR>")

map("t", "<A-[>", "<C-\\><C-n>")
map("t", "<A-k>", "<C-\\><C-n><C-w>k")
map("t", "<A-j>", "<C-\\><C-n><C-w>j")
map("t", "<A-h>", "<C-\\><C-n><C-w>h")
map("t", "<A-l>", "<C-\\><C-n><C-w>l")

-- Command Line Bindings
vim.keymap.set("c", "<C-a>", "<Home>", { noremap = true})
vim.keymap.set("c", "<C-e>", "<End>", { noremap = true})
