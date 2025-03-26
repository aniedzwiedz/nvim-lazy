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
    -- vim.opt_local.relativenumber = false
    vim.opt_local.number = false -- toggle with leader-ul
  end,
})
vim.api.nvim_create_autocmd("BufRead", {
  -- Force `Jenkinsfile` to groovy filetype.
  pattern = { "Jenkinsfile" },
  command = "set ft=groovy",
})
-- Advanced Gemfile

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "Gemfile.*" },
  -- enable wrap mode for json files only
  command = "set filetype=ruby",
})
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "docker-compose*.ym*l" },
  -- enable wrap mode for json files only
  command = "set filetype=yaml.docker-compose",
})
vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "NeogitCommitMessage" },
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.columns = 80
    vim.opt.colorcolumn = "80"
    -- vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- resize neovim split when terminal is resized
vim.api.nvim_command("autocmd VimResized * wincmd =")

-- fix terraform and hcl comment string
-- vim.api.nvim_create_autocmd("FileType", {
--   group = api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
--   callback = function(ev)
--     vim.bo[ev.buf].commentstring = "# %s"
--   end,
--   pattern = { "terraform", "hcl" },
-- })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = {
    "*-ctl/*.yml",
    "*-ctl/*.yaml",
    ".*/tasks/.*.yaml",
    ".*/tasks/.*.yml",
  },
  callback = function()
    vim.bo.filetype = "yaml.ansible"
  end,
})
