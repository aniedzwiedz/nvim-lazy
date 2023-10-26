-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")

---@diagnostic disable-next-line: missing-fields
require("notify").setup({
  background_colour = "#000000",
})

-- require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets/lua.json" } })
require("luasnip.loaders.from_vscode").load({ paths = { "./snippets/" } }) -- Load snippets from my-snippets folder

require("luasnip.loaders.from_vscode").lazy_load()

