-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require 'lazyvim.util'
-- Silent keymap option
-- local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- yank to clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', [["+y]], { desc = 'Yank all' })

-- map("n", "<leader>?", function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   -- require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--   require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
--     --               initial_mode = "normal",
--     --               sorting_strategy = "ascending",
--     winblend = 20,
--     previewer = false,
--   })
-- end, { desc = "[?] Fuzzily search in current buffer]" })

-- Add toggle gitsigns blame line
if Util.has 'gitsigns.nvim' then
  map(
    'n',
    '<leader>ub',
    "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>",
    { desc = 'Toggle current line blame' }
  )
  map('n', '<leader>gl', function()
    require('gitsigns').blame_line { full = false }
  end, { desc = 'View full Blame' })
  --NOTE: <leader>gB
  -- map('n', '<leader>gL', function()
  --   require('gitsigns').blame_line { full = true }
  -- end, { desc = 'View full Git Blame' })
  -- map("n", "<leader>gdo", ":DiffviewOpen<cr>", { desc = "DiffviewOpen " })
end

map('n', '<leader>uD', function()
  vim.diagnostic.config { virtual_text = false }
end, { desc = 'Toggle Diagnosticstic virtual_text' })

-- Select all
map('n', '<leader>a', 'ggVG', { desc = 'Select all' })

-- Change Commit Log to use Lazygit
map('n', '<leader>gD', function()
  LazyVim.lazygit { args = { 'log' } }
end, { desc = 'Lazygit Commit Log' })

-- Copy file paths
map('n', '<leader>fz', '<cmd>let @+ = expand("%")<CR>', { desc = 'Copy File Name' })
map('n', '<leader>fZ', '<cmd>let @+ = expand("%:p")<CR>', { desc = 'Copy File Path' })

-- Replace word under cursor across entire buffer
map(
  'n',
  -- "<leader>cw",
  '<F2>',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { desc = '[c]hange word under cursor' }
)

-- -- Easy find and replace.
-- vim.keymap.set({ "v" }, "<leader>re", '"hy:%s/<C-r>h/<C-r>h/gc<left><left><left>', { desc = "Open search and replace for currently selected text" })
-- vim.keymap.set({ "n" }, "<leader>re", ":%s/<C-r><C-w>/<C-r><C-w>/gc<Left><Left><Left>", { desc = "Open search and replace for word under cursor" })

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
-- map('n', '<leader>go', function()
--   if vim.bo.filetype == 'python' then
--     vim.api.nvim_command 'PyrightOrganizeImports'
--   end
-- end)

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
