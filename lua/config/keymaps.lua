-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
-- System clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("i", "<C-S-v>", '"+p', { desc = "Paste from clipboard" })

local map = require("lazyvim.util").safe_keymap_set
map("n", "<leader>fC", "<cmd>:lua Snacks.picker.lazy()<CR>")

-- NOTE: https://github.com/ibhagwan/fzf-lua
vim.keymap.set({ "i" }, "<C-x><C-f>", function()
  require("fzf-lua").complete_file({
    cmd = "rg --files",
    winopts = { preview = { hidden = true } },
  })
end, { silent = true, desc = "Fuzzy complete file" })

-- find files (default: spc-spc)
vim.keymap.set("n", "<c-p>", function()
  Snacks.picker.git_files({ layout = { preset = "vscode" }, untracked = true })
end, { desc = "Find Files (root dir)" })

vim.keymap.set("n", "<leader>fya", function()
  local str = vim.fn.expand("%:p")
  vim.fn.setreg('"', str)
  vim.fn.setreg("+", str)
  vim.notify("→ " .. str)
end, { desc = " Copy absolute path" })

vim.keymap.set("n", "<leader>fyr", function()
  local str = vim.fn.expand("%:.")
  vim.fn.setreg('"', str)
  vim.fn.setreg("+", str)
  vim.notify("→ " .. str)
end, { desc = " Copy relative path" })

vim.keymap.set("n", "<leader>fyn", function()
  local str = vim.fn.expand("%:t")
  vim.fn.setreg('"', str)
  vim.fn.setreg("+", str)
  vim.notify("→ " .. str)
end, { desc = " Copy basename" })

-- vscode
if vim.g.vscode then
  vim.keymap.set(
    "n",
    "]d",
    "<cmd>lua require('vscode').call('editor.action.marker.next')<cr>",
    { desc = "Next Diagnostic" }
  )
  vim.keymap.set(
    "n",
    "[d",
    "<cmd>lua require('vscode').call('editor.action.marker.previous')<cr>",
    { desc = "Prev Diagnostic" }
  )
  vim.keymap.set(
    "n",
    "gr",
    "<cmd>lua require('vscode').call('editor.action.goToReferences')<cr>",
    { desc = "Goto References" }
  )
  vim.keymap.set(
    "n",
    "gd",
    "<cmd>lua require('vscode').call('editor.action.revealDefinition')<cr>",
    { desc = "Goto Definition" }
  )
  vim.keymap.set(
    "n",
    "gy",
    "<cmd>lua require('vscode').call('editor.action.goToTypeDefinition')<cr>",
    { desc = "Goto Type Definition" }
  )
end
