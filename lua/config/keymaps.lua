-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
-- Silent keymap option
-- local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank all" })
vim.keymap.del("n", "<leader>E") -- diable keymap
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

-- Select all
map("n", "<leader>a", "ggVG", { desc = "Select all" })

-- Change Commit Log to use Lazygit
map("n", "<leader>gD", function()
  LazyVim.lazygit({ args = { "log" } })
end, { desc = "Lazygit Commit Log" })

-- Copy file paths
map("n", "<leader>fz", '<cmd>let @+ = expand("%")<CR>', { desc = "Copy File Name" })
map("n", "<leader>fZ", '<cmd>let @+ = expand("%:p")<CR>', { desc = "Copy File Path" })

-- Replace word under cursor across entire buffer
map(
  "n",
  -- "<leader>cw",
  "<F2>",
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = "[c]hange word under cursor" }
)
-- package-info keymaps
map(
  "n",
  "<leader>cpt",
  "<cmd>lua require('package-info').toggle()<cr>",
  { silent = true, noremap = true, desc = "Toggle" }
)
