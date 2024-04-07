local opt = vim.opt

-- Identation
opt.expandtab = true -- Use spaces instead of TABs
opt.shiftwidth = 4 -- Indent with 4 spaces
opt.softtabstop = 4 -- Use 4 spaces per TAB
opt.breakindent = true -- Indent wrapped lines

-- Searching
opt.ignorecase = true -- Ignore case when searching..
opt.smartcase = true -- unless there is a capital letter in the query
opt.incsearch = true -- Show search results as you type
opt.hlsearch = true -- Highlight matching search results

-- Use 'ripgrep' for grepping
opt.grepprg = "rg --smart-case --vimgrep"
opt.grepformat = {
    "%f:%l:%c:%m",
    "%f:%l:%m",
}

-- Backup, undo and swap files
opt.backup = false -- Disable permanent backups..
opt.writebackup = true -- but enable temporary backups
opt.dir = vim.fn.stdpath("data") .. "/cache/swap"
opt.undofile = true
opt.undodir = vim.fn.stdpath("data") .. "/cache/undo"

-- Completion
opt.pumheight = 10 -- Only show 10 completion candidates
opt.pumblend = 10 -- Add transparency to the pummenu
opt.completeopt = { "menu", "menuone", "noselect" }

-- Command line completion
opt.wildignorecase = true
opt.wildoptions = "pum"

-- UX
opt.updatetime = 100 -- Trigger CursorHold (:h CursorHold) events faster
opt.scrolloff = 4 -- Lines to keep above/below the cursor while scrolling
opt.inccommand = "split" -- Preview offscreen substitutions
opt.splitbelow = true -- Split new windows below the current one
opt.splitright = true -- Split new windows right of the current one
opt.joinspaces = false -- Don't join lines with spaces at the end
opt.wrap = true -- Don't wrap long lines
opt.virtualedit = "block" -- Allow going past the end of line in visual block mode

-- UI
opt.number = true
opt.relativenumber = true
opt.numberwidth = 3
opt.showmode = false
opt.showcmd = false
opt.cmdheight = 1
opt.laststatus = 3
opt.termguicolors = true
opt.signcolumn = "yes"
--opt.statuscolumn = "%=%{v:virtnum < 1 ? (v:relnum ? v:relnum : v:lnum < 10 ? v:lnum . '  ' : v:lnum) : ''}%=%s"
opt.diffopt = { "filler", "internal", "algorithm:histogram", "indent-heuristic", "linematch:60" }

opt.linebreak = true -- Break lines on spaces or TABs
opt.showbreak = "↳ " -- String to put at the start of wrapped lines

opt.smoothscroll = true

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

-- Don't show trailing whitespaces in insert mode
vim.cmd([[
    augroup ListcharsTrail autocmd!
        autocmd InsertEnter * :set listchars-=trail:•
        autocmd InsertLeave * :set listchars+=trail:•
    augroup END
]])

opt.shortmess:append({
    I = false, -- Show the intro screen
    W = true, -- Don't print "written" when editing
    a = true, -- Use abbreviations in messages, e.g., [RO] intead of [readonly]
    c = true, -- Don't show ins-completion-menu messages (match 1 of 2)
    F = true, -- Don't print the file name when opening a file
    s = true, -- Don't show "Search hit BOTTOM" message
})

-- Show the cursor line, but only in normal mode
local group = vim.api.nvim_create_augroup("CursorLine", { clear = true })
local set_cursorline = function(event, value)
    vim.api.nvim_create_autocmd(event, {
        group = group,
        callback = function()
            vim.opt_local.cursorline = value
        end,
    })
end

set_cursorline({ "WinLeave", "InsertEnter" }, false)
set_cursorline({ "BufEnter", "InsertLeave" }, true)

-- Netrw
-- https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/

vim.g.netrw_keepdir = 0
vim.g.netrw_banner = 0
vim.g.netrw_localcopydircmd = "cp -r"
vim.g.netrw_browse_split = 0
vim.g.preview = 1
vim.g.netrw_liststyle = 3
vim.g.netrw_winsize = 20

-- Disable built-ins
local builtin_plugins = {
    loaded_gzip = 1,
    loaded_zip = 1,
    loaded_zipPlugin = 1,
    loaded_tar = 1,
    loaded_tarPlugin = 1,
    loaded_getscript = 1,
    loaded_getscriptPlugin = 1,
    loaded_vimball = 1,
    loaded_vimballPlugin = 1,
    loaded_2html_plugin = 1,
    loaded_matchit = 1,
    loaded_matchparen = 1,
    loaded_logiPat = 1,
    loaded_rrhelper = 1,
    loaded_tutor_mode_plugin = 1,
    loaded_rplugin = 1,
    loaded_bugreport = 1,
    loaded_syntax = 1,
    loaded_spellfile_plugin = 1,
    loaded_python3_provider = 0,
    loaded_node_provider = 0,
    loaded_perl_provider = 0,
    loaded_ruby_provider = 0,
    loaded_synmenu = 1,
    loaded_optwin = 1,
    loaded_compiler = 1,
}

for k, v in pairs(builtin_plugins) do
    vim.g[k] = v
end
