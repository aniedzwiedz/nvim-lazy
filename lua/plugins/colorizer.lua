return {
  "NvChad/nvim-colorizer.lua",
  event = { "BufReadPre", "BufNewFile" },
  config = true,
  opts = {
    user_default_options = {
      names = false
    }
  }
}

-- local M = {
--   "NvChad/nvim-colorizer.lua",
--   event = { "BufReadPost", "BufNewFile" },
-- }
--
-- function M.config()
--   require("colorizer").setup {
--     filetypes = {
--       "typescript",
--       "typescriptreact",
--       "javascript",
--       "javascriptreact",
--       "css",
--       "html",
--       "astro",
--       "lua",
--     },
--     user_default_options = {
--       names = false,
--       rgb_fn = true,
--       tailwind = "both",
--     },
--     buftypes = {},
--   }
-- end
--
-- return M
