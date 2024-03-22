-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- set leader key to space
vim.g.mapleader = " "

local Util = require("lazyvim.util")
-- Silent keymap option
-- local opts = { silent = true }
local opts = { noremap = true, silent = true }
local map = vim.keymap.set
---------------------
-- General Keymaps -------------------
--

-- clear search highlights
map("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlights" })
-- NullLs Info keymap
if Util.has("null-ls.nvim") then
  map("n", "<leader>cn", "<cmd>NullLsInfo<CR>", opts)
end

-- Copy whole file content to clipboard with C-c
map("n", "<C-c>", ":%y+<CR>", opts)
-- Select all
--  keymap.set("n", "<c-a>", "ggvg", opts)

-- Fast saving
-- map("n", "<Leader>w", ":write!<CR>", opts)

-- Select all
-- map("n", "<C-a>", "ggVG", opts)

map("n", "<Esc>", ":nohlsearch<CR>", opts)

-- Keep cursor centered when scrolling
map("n", "<C-d>", "<C-d>zz", opts)
map("n", "<C-u>", "<C-u>zz", opts)

-- Visual --
-- Stay in indent mode
map("v", "<", "<gv", opts)
map("v", ">", ">gv", opts)

-- Move live up or down
-- moving
map("n", "<A-Down>", ":m .+1<CR>", opts)
map("n", "<A-Up>", ":m .-2<CR>", opts)
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("n", "<leader>-", "", { noremap = true, silent = true })
map("n", "<leader>,", "", { noremap = true, silent = true })

-- ["<F2>"] = { ":DiffviewClose<cr>", desc = "Close Diff View" }, -- closing Diffview

-- save file
-- map("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })
-- vim.api.nvim_set_keymap("n", "<leader>w", ":w<cr><esc>", { desc = "Save file" })
vim.api.nvim_set_keymap("n", "<leader>L", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>E", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>`", "", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>,", "", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>-", "", { noremap = true, silent = true })
-- vim.api.nvim_set_keymap("n", "<leader>|", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ww", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wd", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w-", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w|", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sH", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>|", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>,", "", { noremap = true, silent = true })

map("n", "<leader>?", function()
  -- You can pass additional configuration to telescope to change theme, layout, etc.
  -- require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    --               initial_mode = "normal",
    --               sorting_strategy = "ascending",
    winblend = 10,
    previewer = false,
  }))
end, { desc = "[?] Fuzzily search in current buffer]" })

-- DO NOT USE THIS IN YOU OWN CONFIG!!
-- use `map` instead
-- local map = Util.safe_keymap_set

-- map("n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })

-- Gitsigns
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
  map("n", "<leader>gL", function()
    require("gitsigns").blame_line({ full = true })
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

-- Run Tests
map("n", "<leader>t", "<cmd>lua require('neotest').run.run()<CR>", { desc = "Run Test" })
map(
  "n",
  "<leader>tf",
  "<cmd>lua require('neotest').run.run(vim.fn.expand('%'))<CR>",
  { desc = "Run Test File" }
)
map(
  "n",
  "<leader>td",
  "<cmd>lua require('neotest').run.run(vim.fn.getcwd())<CR>",
  { desc = "Run Current Test Directory" }
)
map(
  "n",
  "<leader>tp",
  "<cmd>lua require('neotest').output_panel.toggle()<CR>",
  { desc = "Toggle Test Output Panel" }
)
map("n", "<leader>tl", "<cmd>lua require('neotest').run.run_last()<CR>", { desc = "Run Last Test" })
map("n", "<leader>ts", "<cmd>lua require('neotest').summary.toggle()<CR>", { desc = "Toggle Test Summary" })

-- Filetype-specific keymaps (these can be done in the ftplugin directory instead if you prefer)
map("n", "<leader>go", function()
  if vim.bo.filetype == "python" then
    vim.api.nvim_command("PyrightOrganizeImports")
  end
end)

map("n", "<leader>tc", function()
  if vim.bo.filetype == "python" then
    require("dap-python").test_class()
  end
end)

map("n", "<leader>tm", function()
  if vim.bo.filetype == "python" then
    require("dap-python").test_method()
  end
end)
