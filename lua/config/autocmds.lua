-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("custom_markdown", { clear = true }),
  pattern = { "markdown" },
  callback = function()
    vim.opt_local.cursorline = false -- doesn't look good when used with headline.nvim. toggle with leader-uL
    vim.opt_local.spell = false -- I find spellcheck only useful when writing prose. toggle with leader-us
    vim.opt_local.wrap = false -- inline links make wrapping very weird. toggle with leader-uw
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false -- toggle with leader-ul
  end,
})
