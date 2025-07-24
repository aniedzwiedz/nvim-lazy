-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
local Util = require("lazyvim.util")
-- Silent keymap option
-- local opts = { noremap = true, silent = true }
local map = vim.keymap.set
-- yank to clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]], { desc = "Yank all" })

-- Borderless terminal
-- vim.keymap.set("n", "<C-/>", function()
--   Util.terminal(nil, { border = "none" })
-- end, { desc = "Term with border" })

-- Borderless lazygit
-- vim.api.nvim_set_keymap(
--   "n",
--   "<leader>go",
--   "<cmd>lua _lazygit_toggle()<CR>",
--   { desc = "LazyGit" }
--   -- { noremap = true, silent = true }
-- )

vim.keymap.del("n", "<leader>E") -- diable keymap

vim.keymap.set("n", "<leader>go", function()
  Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false, border = "none" })
end, { desc = "Lazygit (root dir)" })

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
  map('n', '<leader>gL', function()
    require('gitsigns').blame_line { full = true }
  end, { desc = 'View full Git Blame' })
  -- map("n", "<leader>gdo", ":DiffviewOpen<cr>", { desc = "DiffviewOpen " })
end

map("n", "<leader>uD", function()
  vim.diagnostic.config({ virtual_text = false })
end, { desc = "Toggle Diagnosticstic virtual_text" })

-- NOTE: https://github.com/ibhagwan/fzf-lua
vim.keymap.set({ 'i' }, '<C-x><C-f>', function()
  require('fzf-lua').complete_file {
    cmd = 'rg --files',
    winopts = { preview = { hidden = true } },
  }
end, { silent = true, desc = 'Fuzzy complete file' })

-- Select all
-- map("n", "<leader>a", "ggVG", { desc = "Select all" })

-- Change Commit Log to use Lazygit
map("n", "<leader>gD", function()
  require("lazyvim").lazygit({ args = { "log" } })
end, { desc = "Lazygit Commit Log" })

-- find files (default: spc-spc)
vim.keymap.set('n', '<c-p>', function()
  Snacks.picker.git_files { layout = { preset = 'vscode' }, untracked = true }
end, { desc = 'Find Files (root dir)' })

vim.keymap.set('n', '<leader>fZ', function()
  local str = vim.fn.expand '%:p'
  vim.fn.setreg('"', str)
  vim.fn.setreg('+', str)
  vim.notify('→ ' .. str)
end, { desc = ' Copy absolute path' })

-- vim.keymap.set('n', '<leader>fyr', function()
--   local str = vim.fn.expand '%:.'
--   vim.fn.setreg('"', str)
--   vim.fn.setreg('+', str)
--   vim.notify('→ ' .. str)
-- end, { desc = ' Copy relative path' })

vim.keymap.set('n', '<leader>fz', function()
  local str = vim.fn.expand '%:t'
  vim.fn.setreg('"', str)
  vim.fn.setreg('+', str)
  vim.notify('→ ' .. str)
end, { desc = ' Copy file name' })


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
map(
  "n",
  "<leader>cpd",
  "<cmd>lua require('package-info').delete()<cr>",
  { silent = true, noremap = true, desc = "Delete package" }
)
map(
  "n",
  "<leader>cpu",
  "<cmd>lua require('package-info').update()<cr>",
  { silent = true, noremap = true, desc = "Update package" }
)
map(
  "n",
  "<leader>cpi",
  "<cmd>lua require('package-info').install()<cr>",
  { silent = true, noremap = true, desc = "Install package" }
)
map(
  "n",
  "<leader>cpc",
  "<cmd>lua require('package-info').change_version()<cr>",
  { silent = true, noremap = true, desc = "Change package version" }
)
if vim.g.vscode then
  vim.keymap.set(
    'n',
    ']d',
    "<cmd>lua require('vscode').call('editor.action.marker.next')<cr>",
    { desc = 'Next Diagnostic' }
  )
  vim.keymap.set(
    'n',
    '[d',
    "<cmd>lua require('vscode').call('editor.action.marker.previous')<cr>",
    { desc = 'Prev Diagnostic' }
  )
  vim.keymap.set(
    'n',
    'gr',
    "<cmd>lua require('vscode').call('editor.action.goToReferences')<cr>",
    { desc = 'Goto References' }
  )
  vim.keymap.set(
    'n',
    'gd',
    "<cmd>lua require('vscode').call('editor.action.revealDefinition')<cr>",
    { desc = 'Goto Definition' }
  )
  vim.keymap.set(
    'n',
    'gy',
    "<cmd>lua require('vscode').call('editor.action.goToTypeDefinition')<cr>",
    { desc = 'Goto Type Definition' }
  )
end
-- local default_opts = {noremap = true}
-- map('n', '<leader>ff', "<cmd>lua require'telescope.builtin'.find_files({ find_command = {'rg', '--files', '--hidden', '-g', '!.git' }})<cr>", default_opts)

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
