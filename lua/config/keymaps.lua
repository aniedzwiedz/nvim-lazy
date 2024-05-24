-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
vim.g.mapleader = " "

local Util = require "lazyvim.util"
-- Silent keymap option
-- local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])

map("n", "<leader>?", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  -- require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
    --               initial_mode = "normal",
    --               sorting_strategy = "ascending",
    winblend = 10,
    previewer = false,
  })
end, { desc = "[?] Fuzzily search in current buffer]" })

-- Add toggle gitsigns blame line
if Util.has "gitsigns.nvim" then
  map(
    "n",
    "<leader>ub",
    "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>",
    { desc = "Toggle current line blame" }
  )
  map("n", "<leader>gl", function()
    require("gitsigns").blame_line { full = false }
  end, { desc = "View full Blame" })
  map("n", "<leader>gL", function()
    require("gitsigns").blame_line { full = true }
  end, { desc = "View full Git Blame" })
  -- map("n", "<leader>gdo", ":DiffviewOpen<cr>", { desc = "DiffviewOpen " })
end

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

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
map("n", "<leader>go", function()
  if vim.bo.filetype == "python" then
    vim.api.nvim_command "PyrightOrganizeImports"
  end
end)

-- map("n", "<leader>tc", function()
--   if vim.bo.filetype == "python" then
--     require("dap-python").test_class()
--   end
-- end)
--
-- map("n", "<leader>tm", function()
--   if vim.bo.filetype == "python" then
--     require("dap-python").test_method()
--   end
-- end)
