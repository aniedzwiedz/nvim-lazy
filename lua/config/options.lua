-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- NOTE: snacks is a custom picker that is not included in the default options
vim.g.lazyvim_picker = "snacks"

-- Enable clipboard support
vim.opt.clipboard = "unnamedplus"

-- Enable the option to require a Prettier config file
-- If no prettier config file is found, the formatter will not be used
vim.g.lazyvim_prettier_needs_config = false
