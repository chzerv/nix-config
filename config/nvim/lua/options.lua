-- Set <space> as the leader key
vim.g.mapleader = " "

-- Set <\> as the localleader key
vim.g.maplocalleader = "\\"

-- Trigger CursorHold events faster
vim.opt.updatetime = 100

-- Decrease the time to wait for a mapped sequence to complete
vim.opt.timeoutlen = 500

-- Decrease the time to wait for a key-code sequence to complete
vim.opt.ttimeoutlen = 20

-- Indent with 4 spaces
vim.opt.shiftwidth = 4
vim.opt.softtabstop = 4
vim.opt.expandtab = true
vim.opt.smartindent = true

-- Completion
vim.opt.completeopt = { "menu", "menuone", "preview" }
vim.opt.pumheight = 10 -- Only show 10 completion candidates
vim.opt.pumblend = 10 -- Add transparency to the pummenu

-- Ignore case when searching, unless there is an uppercase letter in the query
vim.opt.ignorecase = true
vim.opt.smartcase = true

-- Only use temporary backup files
vim.opt.backup = false
vim.opt.writebackup = true

-- Save undo history
vim.opt.undofile = true

-- UX
vim.opt.scrolloff = 4 -- Lines to keep above/below the cursorline while scrolling
vim.opt.inccommand = "split" -- Preview offscreen substitutions
vim.opt.splitbelow = true -- Create new splits below the current window
vim.opt.splitright = true -- Create new splits right of the current window
vim.opt.virtualedit = "block" -- Allow going past the end of the line in visual block mode
vim.opt.linebreak = true -- Break lines on space or TAB
vim.opt.showbreak = "↳ " -- String to put at the start of wrapped lines

-- UI tweaks
vim.wo.number = true
vim.opt.relativenumber = true
vim.opt.numberwidth = 3 -- Minimal number of cols to use for line numbers
vim.opt.showmode = false -- Don't show the current mode under the statusline
vim.opt.showcmd = false
vim.opt.laststatus = 3
vim.opt.cmdheight = 1
vim.opt.signcolumn = "yes"
vim.opt.winborder = "rounded"

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
vim.o.foldtext =
    [[substitute(getline(v:foldstart),'\\t',repeat('\ ',&tabstop),'g').'...'.trim(getline(v:foldend)) . ' [' . (v:foldend - v:foldstart + 1) . 'ℓ] ']]
vim.wo.foldnestmax = 3 -- Maximum fold nesting
vim.wo.foldminlines = 1 -- Create a fold only if it takes 2 or more lines (default)
vim.wo.foldlevel = 99

vim.opt.shortmess:append({
    I = true, -- Don't show the intro screen
    W = true, -- Don't print "written" when editing
    a = true, -- Use abbreviations in messages, e.g., [RO] intead of [readonly]
    c = true, -- Don't show ins-completion-menu messages (match 1 of 2)
    F = true, -- Don't print the file name when opening a file
    s = true, -- Don't show "Search hit BOTTOM" message
})

-- Ignore files when expanding wildcards
vim.opt.wildignore = [[
*.7z,*bz2,*.gz,*.rar,*tar,*xz,*.zip
*.doc*,*.pdf,*.odp,*.ods,*.odt,*.ppt,*.xls,*.xlsx
*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp,*.au
*.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg
*.mp3,*.oga,*.ogg,*.wav,*.flac,*.opus
*.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class,*.so
*.aux,*.out,*.toc
*.eot,*.otf,*.ttf,*.woff
*.swp,.lock,.DS_Store,._*
.git,.hg,.svn
*.swp,.lock
*/tmp/*,**/node_modules/**,**/target/**,**.terraform/**,.DS_Store
._*
]]

-- Disable healthchecks for unused providers
vim.g.loaded_python3_provider = 0
vim.g.loaded_ruby_provider = 0
vim.g.loaded_perl_provider = 0
vim.g.loaded_node_provider = 0
