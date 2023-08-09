-- bootstrap lazy.nvim, LazyVim and your plugins
-- require("config.colorscheme")
require("config.lazy")
-- require("plugins.lsp")
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>")
