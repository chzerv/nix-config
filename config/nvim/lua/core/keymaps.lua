local g = vim.g
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

-- Setup leader keys
g.mapleader = " "
g.maplocalleader = "\\"

-- Center the cursor after scrolling down/up
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Center the cursor and open folds when navigating through search matches
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Yank/paste to/from the system clipboard
-- 'vim.opt.clipboard = "unnamedplus"' can also be set to have VIM use the system clipboard
map({ "n", "x" }, "<leader>y", [["+y"]], opts)
map("n", "<leader>Y", [["+Y"]], opts)
map({ "n", "x" }, "<leader>p", [["+p"]], opts)
map("n", "<leader>P", [["+P"]], opts)

-- Avoid clobbering yanked content when pasting in visual mode
-- ref: https://github.com/neovim/neovim/issues/19354
map("x", "p", "P", opts)
map("x", "P", "p", opts)

-- Don't yank changes
map("n", "c", "\"_c")
map("n", "C", "\"_C")

-- Delete without yanking
map({ "n", "x" }, "<leader>d", "\"_d", opts)

-- Re-select block after indenting
map("x", "<", "<gv", opts)
map("x", ">", ">gv", opts)

-- Allow moving through wrapped lines
map("n", "k", "gk", opts)
map("n", "j", "gj", opts)
map("n", "gk", "k", opts)
map("n", "gj", "j", opts)

-- Put blank lines below/above current line
map("n", "[<Space>", "<Cmd>put! =repeat(nr2char(10), v:count1) <Bar> ']+1<CR>", opts)
map("n", "]<Space>", "<Cmd>put =repeat(nr2char(10), v:count1) <Bar> '[-1<CR>", opts)

-- Toggle spellcheck
-- The blank string in the mode indicates that this is a 'map' mapping
map("", "<F6>", "<Cmd>setlocal spell! spelllang=en_us<CR>")
map("", "<F7>", "<Cmd>setlocal spell! spelllang=el<CR>")
map("", "<F8>", "<Cmd>setlocal spell! spelllang=en_us,el<CR>")

-- Autocorrect the last spelling error
map("i", "<C-s>", "<c-g>u<Esc>[s1z=`]a<c-g>u", opts)

-- Zoom focused split, just like tmux
map("n", "<leader>z", "<Plug>(ToggleZoom)", opts)

-- Use ESC to turn off search highlighting
map("n", "<Esc>", "<cmd> :noh <CR>")

-- Open a quickfix window with all the terms I last searched for
-- (credits to Steve Losh)
map("n", "<leader>q/", [[<Cmd>execute 'vimgrep /'.@/.'/g %'<CR>copen<CR><CR>nohls<CR>]])

-- Substitute the word under cursor...
map("n", "<leader>rl", ":s/<C-R><C-W>//g<left><left>") -- line wise
map("n", "<leader>rb", ":%s/<C-R><C-W>//g<left><left>") -- buffer wise

-- Substitution in visual selection
map("x", "<leader>rv", [[:s/\%V]])

-- "Invert" the word under cursor, e.g., true -> false
map("n", "!", "<cmd>lua require'my_plugins.invert-text'.invert()<cr>", opts)

-- Go to help page of the word under the cursor
map("n", "gh", "yiw:help <C-R><C-W><CR>", opts)

-- Search within visual selection
-- https://www.reddit.com/r/neovim/comments/zy3qq0/til_search_within_visual_selection/
vim.keymap.set("v", "<m-/>", "<esc>/\\%V")

-- Resize windows using Ctrl + arrow keys
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>", { desc = "Increase window height" })
vim.keymap.set("n", "<C-Down>", "<cmd>resize -2<cr>", { desc = "Decrease window height" })
vim.keymap.set("n", "<C-Left>", "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
vim.keymap.set("n", "<C-Right>", "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })

-- Tab navigation
map("n", "[t", ":tabprevious<CR>", opts)
map("n", "]t", ":tabnext<CR>", opts)
map("n", "<C-w><C-t>", ":tabnew<CR>", opts)
map("n", "<C-w><C-q>", ":tabclose<CR>", opts)

-- Buffer navigation
map("n", "[b", ":bprevious<CR>", opts)
map("n", "]b", ":bnext<CR>", opts)
map("n", "<leader><leader>", "<c-^>")

-- Quickfix navigation
map("n", "[q", ":cprevious<CR>", opts)
map("n", "]q", ":cnext<CR>", opts)
map("n", "]Q", ":cfirst<CR>")
map("n", "[Q", ":clast<CR>")
map("n", "<Bslash>q", ":cclose<CR>", opts)

-- Location list navigation
map("n", "[l", ":lprevious<CR>", opts)
map("n", "]l", ":lnext<CR>", opts)
map("n", "]L", ":lfirst<CR>")
map("n", "[L", ":llast<CR>")
map("n", "<Bslash>l", ":lclose<CR>", opts)

-- Mimic shell bindings in VIM
map("i", "<C-e>", "<End>")
map("i", "<C-a>", "<Home>")

-- Since we disable netrw, create a binding to replicate "gx"
-- Credits to kutsan
-- map("n", "gx", function()
--     local url = vim.fn.expand("<cfile>")
--     local escaped_url = vim.fn.escape(url, "#%!")
--     vim.cmd(("silent !xdg-open \"%s\""):format(escaped_url))
-- end, { silent = true })

-- Neovim Terminal
map("n", "<C-\\>", [[<cmd>lua require'my_plugins.term'.toggle_term("split", 15)<cr>]], opts)
map("t", "<C-\\>", "<C-\\><C-n><cmd>lua require'my_plugins.term'.toggle_term('split', 15)<cr>", opts)
map("n", "<leader>tt", "<cmd>lua require'my_plugins.term'.launch_term_in_tab()<cr>", opts)

map("n", "<leader>ts", "<cmd>lua require'my_plugins.term'.send_line_to_term()<cr>", opts)
map("v", "<leader>ts", "<cmd>lua require'my_plugins.term'.send_visual_to_term()<cr>", opts)

map("t", "[t", "<C-\\><C-n><cmd>tabprevious<CR>", opts)
map("t", "]t", "<C-\\><C-n><cmd>tabnext<CR>", opts)

map("t", "<A-[>", "<C-\\><C-n>", { noremap = true })
map("t", "<A-k>", "<C-\\><C-n><C-w>k", { noremap = true })
map("t", "<A-j>", "<C-\\><C-n><C-w>j", { noremap = true })
map("t", "<A-h>", "<C-\\><C-n><C-w>h", { noremap = true })
map("t", "<A-l>", "<C-\\><C-n><C-w>l", { noremap = true })

-- Command Line Bindings
map("c", "<C-a>", "<Home>", { noremap = true })
map("c", "<C-e>", "<End>", { noremap = true })
