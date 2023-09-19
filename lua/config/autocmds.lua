-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

-- Disable autoformat for lua
vim.api.nvim_create_autocmd({ "FileType" }, {
  -- pattern = { "bash", "zsh" },
  pattern = { "lua" },
  callback = function()
    ---@diagnostic disable-next-line: inject-field
    vim.b.autoformat = true
  end,
})
