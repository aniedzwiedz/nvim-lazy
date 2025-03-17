-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
--
local map = require("lazyvim.util").safe_keymap_set
map("n", "<leader>fC", "<cmd>:lua Snacks.picker.lazy()<CR>")

-- NOTE: https://github.com/ibhagwan/fzf-lua
vim.keymap.set({ "i" }, "<C-x><C-f>", function()
  require("fzf-lua").complete_file({
    cmd = "rg --files",
    winopts = { preview = { hidden = true } },
  })
end, { silent = true, desc = "Fuzzy complete file" })
