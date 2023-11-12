-- local config = function()
--   local theme = require("lualine.themes.gruvbox")
--
--   -- -- set bg transparency in all modes
--   -- theme.normal.c.bg = nil
--   -- theme.insert.c.bg = nil
--   -- theme.visual.c.bg = nil
--   -- theme.replace.c.bg = nil
--   -- theme.command.c.bg = nil
--
--   require("lualine").setup({
--     options = {
--       theme = theme,
--       globalstatus = true,
--     },
--     tabline = {
--       lualine_a = { "mode" },
--       lualine_b = { "buffers" },
--       lualine_x = { "encoding", "fileformat", "filetype" },
--       lualine_y = { "progress" },
--       lualine_z = { "location" },
--     },
--     sections = {},
--   })
-- end

return {
  "nvim-lualine/lualine.nvim",
  options = { theme = "ayu_dark" },
  -- options = { theme = "nord" },
  lazy = false,
  sections = {
    -- lualine_a = { {"branch", icon =""} },
    -- lualine_b = { diff },
    -- lualine_c = { "diagnostics" },
    -- lualine_x = { copilot },
    -- lualine_y = { "filetype" },
    -- lualine_z = { "progress" },
    lualine_a = { "mode" },
    -- lualine_b = { "branch" },
    -- lualine_b = { { "branch", icon = "" } },
    -- lualine_c = { diff },
    -- lualine_x = { "diagnostics", copilot },
    -- lualine_y = { "filetype" },
    -- lualine_z = { "progress" },
  },
  extensions = { "quickfix", "man", "fugitive" },
  -- config = config,
  -- config = function(_, opts)
  --   -- local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
  --   -- vim.api.nvim_set_hl(0, "Copilot", { fg = "#6CC644", bg = sl_hl.background })
  --   local icons = require("config.icons")
  --   local diff = {
  --     "diff",
  --     colored = true,
  --     symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
  --   }
  -- end,
}
