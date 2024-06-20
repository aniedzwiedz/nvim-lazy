-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
-- This file is automatically loaded by plugins.core
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- Enable LazyVim auto format
vim.g.autoformat = false

-- LazyVim root dir detection
-- Each entry can be:
-- * the name of a detector function like `lsp` or `cwd`
-- * a pattern or array of patterns like `.git` or `lua`.
-- * a function with signature `function(buf) -> string|string[]`
vim.g.root_spec = { 'lsp', { '.git', 'lua' }, 'cwd' }
-- Hide deprecation warnings
vim.g.deprecation_warnings = false

-- Show the current document symbols location from Trouble in lualine
vim.g.trouble_lualine = true

LazyVim.terminal.setup 'zsh'
local opt = vim.opt

opt.autowrite = true -- Enable auto write
-- opt.clipboard = "unnamedplus" -- Sync with system clipboard
opt.clipboard = vim.env.SSH_TTY and '' or 'unnamedplus' -- Sync with system clipboard
opt.conceallevel = 0 -- Hide/show * markup for bold and italic
-- opt.completeopt = "menuone,noselect" -- Set completeopt to have a better completion experience
opt.completeopt = 'menu,menuone,noselect'
opt.backup = false -- create a backup file
opt.confirm = true -- Confirm to save changes before exiting modified buffer
opt.cursorline = true -- Enable highlighting of the current line
opt.expandtab = true -- Use spaces instead of tabs
-- opt.formatoptions = 'jcroqlnt' -- tcqj
-- opt.grepformat = '%f:%l:%c:%m'
opt.grepprg = 'rg --vimgrep'
opt.ignorecase = true -- Ignore case
opt.inccommand = 'nosplit' -- preview incremental substitute
opt.laststatus = 3 -- global statusline
-- opt.listchars = { eol = "↵" }   -- End of line characters
opt.listchars = {
  eol = '⤶',
  -- space = "❤",
  -- trail = "✚",
  extends = '◀',
  precedes = '▶',
}
opt.list = true -- Show some invisible characters (tabs...
opt.mouse = 'a' -- Enable mouse mode
opt.number = true -- Print line number
opt.pumblend = 10 -- Popup blend
opt.pumheight = 10 -- Maximum number of entries in a popup
opt.relativenumber = true -- Relative line numbers
opt.scrolloff = 4 -- Lines of context
opt.sessionoptions = { 'buffers', 'curdir', 'tabpages', 'winsize', 'help', 'globals', 'skiprtp' }
opt.shiftround = true -- Round indent
opt.shiftwidth = 2 -- Size of an indent
opt.shortmess:append { W = true, I = true, c = true, C = true }
opt.showmode = false -- Dont show mode since we have a statusline
opt.sidescrolloff = 8 -- Columns of context
opt.signcolumn = 'yes' -- Always show the signcolumn, otherwise it would shift the text each time
opt.smartcase = true -- Don't ignore case with capitals
opt.smartindent = true -- Insert indents automatically
opt.spelllang = { 'en' }
opt.splitbelow = true -- Put new windows below current
opt.splitkeep = 'screen'
opt.splitright = true -- Put new windows right of current
opt.tabstop = 2 -- Number of spaces tabs count for
opt.termguicolors = true -- True color support
opt.timeoutlen = 300
opt.undofile = true
opt.undolevels = 10000
opt.updatetime = 200 -- Save swap file and trigger CursorHold
opt.virtualedit = 'block' -- Allow cursor to move where there is no text in visual block mode
opt.wildmode = 'longest:full,full' -- Command-line completion mode
opt.winminwidth = 5 -- Minimum window width
opt.wrap = true -- Enable line wrap
opt.fillchars = {
  foldopen = '',
  foldclose = '',
  -- fold = "⸱",
  fold = ' ',
  foldsep = ' ',
  diff = '╱',
  eob = ' ',
}

if vim.fn.has 'nvim-0.10' == 1 then
  opt.smoothscroll = true
end

-- Folding
vim.opt.foldlevel = 99

if vim.fn.has 'nvim-0.10' == 1 then
  opt.smoothscroll = true
  opt.foldexpr = "v:lua.require'lazyvim.util'.ui.foldexpr()"
  opt.foldmethod = 'expr'
  opt.foldtext = ''
else
  opt.foldmethod = 'indent'
  opt.foldtext = "v:lua.require'lazyvim.util'.ui.foldtext()"
end
-- Fix markdown indentation settings
vim.g.markdown_recommended_style = 0

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
-- vim.g.lazyvim_prettier_needs_config = false

-- set the global variable NOTE: https://www.lazyvim.org/extras/lang/python
vim.g.python_host_prog = '/usr/sbin/python3'
vim.g.lazyvim_python_lsp = 'pyright'
vim.g.lazyvim_python_ruff = 'ruff_lsp'

-- get the global variable
-- local python_path = vim.g.python_host_prog
