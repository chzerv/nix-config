local opt = vim.opt

-- Update time and timeout lengths
opt.updatetime = 100 -- Trigger CursorHold events faster
opt.timeoutlen = 500 -- Time to wait for a mapped sequence to complete (defaults to 1000)
opt.ttimeoutlen = 20 -- Time to wait for a key-code sequence to complete (defaults to 50)

-- Indent with 4 spaces instead of TABs
opt.shiftwidth = 4
opt.softtabstop = 4
opt.expandtab = true
opt.smartindent = true

-- Better search
opt.ignorecase = true -- Ignore case when searching...
opt.smartcase = true -- unless there is an uppercase letter in the query

-- Backup, undo and swap files
opt.backup = false -- Disable permanent backups..
opt.writebackup = true -- but enable temporary backups
opt.dir = vim.fn.stdpath("data") .. "/cache/swap"
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/cache/undo"

-- UX
opt.scrolloff = 4 -- Lines to keep above/below the cursorline while scrolling
opt.inccommand = "split" -- Preview offscreen substitutions
opt.splitbelow = true -- Create new splits below the current window
opt.splitright = true -- Create new splits right of the current window
opt.virtualedit = "block" -- Allow going past the end of the line in visual block mode
opt.linebreak = true -- Break lines on space or TAB
opt.showbreak = "↳ " -- String to put at the start of wrapped lines

-- UI tweaks
opt.number = true
opt.relativenumber = true
opt.numberwidth = 3 -- Minimal number of cols to use for line numbers
opt.showmode = false -- Don't show the current mode under the statusline
opt.showcmd = false
opt.laststatus = 3
opt.cmdheight = 1
opt.signcolumn = "yes"

-- Visualize tabs, spaces and non-breaking spaces
opt.list = true
opt.listchars = {
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

opt.shortmess:append({
    I = true, -- Don't show the intro screen
    W = true, -- Don't print "written" when editing
    a = true, -- Use abbreviations in messages, e.g., [RO] intead of [readonly]
    c = true, -- Don't show ins-completion-menu messages (match 1 of 2)
    F = true, -- Don't print the file name when opening a file
    s = true, -- Don't show "Search hit BOTTOM" message
})

-- Ignore files when expanding wildcards
opt.wildignore = [[
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
