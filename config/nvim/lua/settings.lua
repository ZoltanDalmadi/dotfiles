local set = vim.opt
local cmd = vim.cmd

set.autowrite     = true          -- Auto read changes to buffer
set.cursorline    = true          -- Highlight current line
set.number        = true          -- Show line numbers
set.shiftwidth    = 4             -- Number of spaces in autoindent
set.tabstop       = 4             -- Tab is 4 spaces wide
set.expandtab     = true          -- Use spaces instead of tabs
set.backup        = false         -- Disable backups
set.splitright    = true
set.splitbelow    = true
set.updatetime    = 500
set.mouse         = 'a'
set.clipboard     = 'unnamedplus'
set.swapfile      = false
set.showmatch     = true
set.termguicolors = true

set.background  = 'dark'

set.completeopt = 'menu,menuone,noselect'

vim.g.mapleader = ','

cmd [[colorscheme dracula]]
cmd [[au BufWritePre * :%s/\s\+$//e]]
cmd [[au BufWritePre * :%s/\s\+$//e]]
cmd [[au FileType html,javascript,javascriptreact,css,scss,typescript,lua setlocal ts=2 sw=2 et sts=2 ]]
