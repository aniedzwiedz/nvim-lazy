-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local Util = require("lazyvim.util")
-- Silent keymap option
-- local opts = { noremap = true, silent = true }
-- local map = vim.keymap.set
-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank all" })
-- System clipboard
vim.keymap.set("v", "<C-c>", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set("i", "<C-S-v>", '"+p', { desc = "Paste from clipboard" })

vim.keymap.del("n", "<leader>E") -- diable keymap

local map = require("lazyvim.util").safe_keymap_set
map("n", "<leader>fC", "<cmd>:lua Snacks.picker.lazy()<CR>")

-- Add toggle gitsigns blame line
if Util.has("gitsigns.nvim") then
  map(
    "n",
    "<leader>ub",
    "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>",
    { desc = "Toggle current line blame" }
  )
  map("n", "<leader>gl", function()
    require("gitsigns").blame_line({ full = false })
  end, { desc = "View full Blame" })
  --NOTE: <leader>gB
  map("n", "<leader>gL", function()
    require("gitsigns").blame_line({ full = true })
  end, { desc = "View full Git Blame" })
  -- map("n", "<leader>gdo", ":DiffviewOpen<cr>", { desc = "DiffviewOpen " })
end

map("n", "<leader>uD", function()
  vim.diagnostic.config({ virtual_text = false })
end, { desc = "Toggle Diagnosticstic virtual_text" })

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

-- NOTE: new in nvim 11.0
--
-- vim.diagnostic.config({
--   -- Use the default configuration
--   -- virtual_lines = true,
--
--   -- Alternatively, customize specific options
--   virtual_lines = {
--     -- Only show virtual line diagnostics for the current cursor line
--     current_line = true,
--   },
-- })
-- Replace word under cursor across entire buffer
map(
  "n",
  -- "<leader>cw",
  "<F2>",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "[c]hange word under cursor" }
)
-- -- Add toggle gitsigns blame line
-- if Util.has("gitsigns.nvim") then
--   map(
--     "n",
--     "<leader>ub",
--     "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>",
--     { desc = "Toggle current line blame" }
--   )
--   map("n", "<leader>gl", function()
--     require("gitsigns").blame_line({ full = false })
--   end, { desc = "View full Blame" })
--   --NOTE: <leader>gB
--   map("n", "<leader>gL", function()
--     require("gitsigns").blame_line({ full = true })
--   end, { desc = "View full Git Blame" })
--   -- map("n", "<leader>gdo", ":DiffviewOpen<cr>", { desc = "DiffviewOpen " })
-- end
-- -- yamk all to clipboard
-- vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank all" })

-- NOTE: do i want to overwrite dimming from LazyVim
-- map("n", "<leader>uD", function()
--   vim.diagnostic.config({ virtual_text = false })
-- end, { desc = "Toggle Diagnosticstic virtual_text" })

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
