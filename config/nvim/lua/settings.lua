-- Set <space> as the leader key
vim.g.mapleader = " "

-- Set <\> as the localleader key
vim.g.maplocalleader = "\\"

-- Trigger CursorHold events faster
vim.o.updatetime = 100

-- Decrease the time to wait for a mapped sequence to complete
vim.o.timeoutlen = 500

-- Decrease the time to wait for a key-code sequence to complete
vim.o.ttimeoutlen = 20

-- Indentation
vim.o.shiftwidth = 4
vim.o.softtabstop = 4
vim.o.expandtab = true
-- vim.o.smartindent = true

-- Completion
vim.o.completeopt = "menuone,noselect,noinsert"
vim.o.pumheight = 10 -- Only show 10 completion candidates
vim.o.pumblend = 10 -- Add transparency to the pummenu
vim.opt.wildignore:append({ "*.pyc", "node_modules", ".git", ".DS_Store", "**.terraform/**", ".lock" })

-- Make search case insensive, unless there is a capital letter in the query or /C is used.
vim.o.ignorecase = true
vim.o.smartcase = true

-- Only use temporary backup files
vim.o.backup = false
vim.o.writebackup = true

-- Save undo history
vim.o.undofile = true

-- UX
vim.o.scrolloff = 4 -- Lines to keep above/below the cursorline while scrolling
vim.o.inccommand = "split" -- Preview offscreen substitutions
vim.o.splitbelow = true -- Create new splits below the current window
vim.o.splitright = true -- Create new splits right of the current window
vim.o.virtualedit = "block" -- Allow going past the end of the line in visual block mode
vim.o.linebreak = true -- Break lines on space or TAB
vim.o.showbreak = "↳ " -- String to put at the start of wrapped lines
vim.opt.diffopt = "internal,filler,closeoff,linematch:60"

-- UI tweaks
vim.wo.number = true
vim.wo.relativenumber = true
vim.wo.signcolumn = "yes"
vim.wo.numberwidth = 3 -- Minimal number of cols to use for line numbers
vim.o.showmode = false -- Don't show the current mode under the statusline
vim.o.showcmd = false
vim.o.laststatus = 3
vim.o.cmdheight = 1
vim.o.winborder = "rounded"
vim.o.termguicolors = true

-- Visualize tabs, spaces and non-breaking spaces
vim.opt.list = true
vim.opt.listchars = {
    tab = "» ",
    nbsp = "␣",
    trail = "•",
    extends = "›",
    precedes = "‹",
}

-- Change how folds look
-- For example, folding a 4 line function will now appear as: funcName = { ... } [4ℓ]
vim.wo.foldtext = ""
vim.o.foldlevelstart = 99
vim.o.foldcolumn = "1"

vim.opt.shortmess:append({
    I = true, -- Don't show the intro screen
    W = true, -- Don't print "written" when editing
    a = true, -- Use abbreviations in messages, e.g., [RO] intead of [readonly]
    c = true, -- Don't show ins-completion-menu messages (match 1 of 2)
    F = true, -- Don't print the file name when opening a file
    s = true, -- Don't show "Search hit BOTTOM" message
})

-- Disable healthchecks for unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
