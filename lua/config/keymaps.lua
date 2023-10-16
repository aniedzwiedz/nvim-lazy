-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- set leader key to space
vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local Util = require("lazyvim.util")
-- Silent keymap option
local opts = { silent = true }

---------------------
-- General Keymaps -------------------
--

-- clear search highlights
keymap.set("n", "<leader>h", ":nohl<CR>", { desc = "Clear search highlights" })
-- NullLs Info keymap
if Util.has("null-ls.nvim") then
  keymap.set("n", "<leader>cn", "<cmd>NullLsInfo<CR>", opts)
end

-- Copy whole file content to clipboard with C-c
keymap.set("n", "<C-c>", ":%y+<CR>", opts)

-- Visual --
-- Stay in indent mode
keymap.set("v", "<", "<gv", opts)
keymap.set("v", ">", ">gv", opts)

-- Move live up or down
-- moving
keymap.set("n", "<A-Down>", ":m .+1<CR>", opts)
keymap.set("n", "<A-Up>", ":m .-2<CR>", opts)
keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)
keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)

-- ["<F2>"] = { ":DiffviewClose<cr>", desc = "Close Diff View" }, -- closing Diffview

-- save file
-- keymap.set("n", "<leader>w", "<cmd>w<cr><esc>", { desc = "Save file" })
-- vim.api.nvim_set_keymap("n", "<leader>w", ":w<cr><esc>", { desc = "Save file" })
vim.api.nvim_set_keymap("n", "<leader>L", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>l", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>E", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>`", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>,", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>-", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>|", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>ww", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wd", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w-", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>w|", "", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>sH", "", { noremap = true, silent = true })

-- vim.keymap.set('n', '<leader>?', function()
--   -- You can pass additional configuration to telescope to change theme, layout, etc.
--   require('telescope.builtin').current_buffer_fuzzy_find(require('telescope.themes').get_dropdown {
--     winblend = 10,
--     previewer = false,
--   })
-- end, { desc = '[?] Fuzzily search in current buffer]' })

-- Gitsigns
-- Add toggle gitsigns blame line
if Util.has("gitsigns.nvim") then
  keymap.set("n", "<leader>ub", "<cmd>lua require('gitsigns').toggle_current_line_blame()<CR>", {
    desc = "Toggle current line blame",
    keymap.set("n", "<leader>gdo", ":DiffviewOpen<cr>", { desc = "DiffviewOpen " }),
  })
end
