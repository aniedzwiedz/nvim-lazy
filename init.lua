-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("notify").setup({
  background_colour = "#000000",
})

-- Enable true color support
vim.o.termguicolors = true

-- Set a transparent background (adjust the opacity to your preference)
vim.cmd("hi Normal guibg=NONE ctermbg=NONE")
vim.cmd("hi SignColumn guibg=NONE ctermbg=NONE")
vim.cmd("hi LineNr guibg=NONE ctermbg=NONE")

-- Set the theme colors (you can customize these)
vim.cmd("hi Comment guifg=#A0A0A0 ctermfg=8")
vim.cmd("hi CursorLine guibg=#303030 ctermbg=235")
vim.cmd("hi CursorLineNr guifg=#FFFFFF ctermfg=15")
vim.cmd("hi VertSplit guifg=#303030 ctermfg=235")
vim.cmd("hi StatusLine guibg=#303030 ctermbg=235")
vim.cmd("hi StatusLineNC guibg=#303030 ctermbg=235")
