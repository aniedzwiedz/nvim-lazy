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
  -- dependencies = { { "nvim-tree/nvim-web-devicons", lazy = true } },
  -- options = {
  --   theme = "ayu_dark",
  -- },
  -- options = { theme = "nord" },
  -- lazy = false,
  -- opts = function(_, opts)
  --   table.insert(opts.sections.lualine_x, 2, require("lazyvim.util").lualine.cmp_source("codeium"))
  --   local function lspClients()
  --     -- local msg = "No Active Lsp"
  --     local msg = ""
  --     local buf_ft = vim.api.nvim_buf_get_option(0, "filetype")
  --     local clients = vim.lsp.get_active_clients()
  --     if next(clients) == nil then
  --       return msg
  --     end
  --     for _, client in ipairs(clients) do
  --       local filetypes = client.config.filetypes
  --       if filetypes and vim.fn.index(filetypes, buf_ft) ~= -1 then
  --         return client.name
  --       end
  --     end
  --     return msg
  --   end
  -- end,
  event = "VeryLazy",

  -- options = {
  --   -- theme = 'tokyonight',
  --   -- theme = "catppuccin",
  --   theme = "auto",
  --   component_separators = "|",
  --   -- component_separators = { left = "", right = "" },
  --   -- section_separators = { left = "", right = "" },
  --   -- section_separators = { left = "", right = "" },
  --   always_divide_middle = false,
  --   globalstatus = false,
  -- },
  --
  opts = function(_, opts)
    table.insert(opts.sections.lualine_x, 2, require("lazyvim.util").lualine.cmp_source("codeium"))
  end,

  sections = {
    -- lualine_a = { {"branch", icon =""} },
    -- lualine_b = { diff },
    -- lualine_c = { "diagnostics" },
    -- lualine_x = { copilot },
    -- lualine_y = { "filetype" },
    -- lualine_z = { "progress" },
    -- lualine_a = { "mode", right_padding = 2, icon = "" },
    -- lualine_b = { "branch" },
    -- lualine_b = { { "branch", icon = "" } },
    -- lualine_c = { diff },
    -- lualine_x = { "diagnostics", copilot },
    -- lualine_y = { "filetype" },
    -- lualine_z = { "progress" },

    lualine_x = {
      -- "mason",
      {
        require("lazy.status").updates,
        cond = require("lazy.status").has_updates,
        color = { fg = "#ff9e64" },
      },
    },
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
--

-- local M = {
--   "nvim-lualine/lualine.nvim",
-- }
--
-- function M.config()
--   local sl_hl = vim.api.nvim_get_hl_by_name("StatusLine", true)
--   vim.api.nvim_set_hl(0, "Copilot", { fg = "#6CC644", bg = sl_hl.background })
--   local icons = require("config.icons")
--   local diff = {
--     "diff",
--     colored = true,
--     symbols = { added = icons.git.LineAdded, modified = icons.git.LineModified, removed = icons.git.LineRemoved }, -- Changes the symbols used by the diff.
--   }
--
--   local copilot = function()
--     local buf_clients = vim.lsp.get_active_clients({ bufnr = 0 })
--     if #buf_clients == 0 then
--       return "LSP Inactive"
--     end
--
--     local buf_client_names = {}
--     local copilot_active = false
--
--     for _, client in pairs(buf_clients) do
--       if client.name ~= "null-ls" and client.name ~= "copilot" then
--         table.insert(buf_client_names, client.name)
--       end
--
--       if client.name == "copilot" then
--         copilot_active = true
--       end
--     end
--
--     if copilot_active then
--       return "%#Copilot#" .. icons.git.Octoface .. "%*"
--     end
--     return ""
--   end
--
--   require("lualine").setup({
--     options = {
--       -- component_separators = { left = "", right = "" },
--       -- section_separators = { left = "", right = "" },
--       component_separators = { left = "", right = "" },
--       section_separators = { left = "", right = "" },
--       opts = function(_, opts)
--         table.insert(opts.sections.lualine_x, 2, require("lazyvim.util").lualine.cmp_source("codeium"))
--       end,
--       --   event = "VeryLazy",
--       -- ignore_focus = { "NvimTree" },
--     },
--     sections = {
--       -- lualine_a = { {"branch", icon =""} },
--       -- lualine_b = { diff },
--       -- lualine_c = { "diagnostics" },
--       -- lualine_x = { copilot },
--       -- lualine_y = { "filetype" },
--       -- lualine_z = { "progress" },
--       -- lualine_a = { "mode" },
--       lualine_b = { "branch" },
--       lualine_c = { diff },
--       lualine_x = { "diagnostics", copilot },
--       lualine_y = { "filetype" },
--       lualine_z = { "progress" },
--     },
--     extensions = { "quickfix", "man", "fugitive" },
--   })
-- end
--
-- return M

-- return {
--   "nvim-lualine/lualine.nvim",
--   dependencies = { "nvim-tree/nvim-web-devicons" },
--   config = function()
--     local lualine = require("lualine")
--     local lazy_status = require("lazy.status") -- to configure lazy pending updates count
--
--     local colors = {
--       blue = "#65D1FF",
--       green = "#3EFFDC",
--       violet = "#FF61EF",
--       yellow = "#FFDA7B",
--       red = "#FF4A4A",
--       fg = "#c3ccdc",
--       bg = "#112638",
--       inactive_bg = "#2c3043",
--     }
--
--     -- configure lualine with modified theme
--     lualine.setup({
--       options = {
--         theme = require("lualine.themes.auto"),
-- --   local theme = require("lualine.themes.gruvbox")
--       },
--       sections = {
--         lualine_x = {
--           {
--             lazy_status.updates,
--             cond = lazy_status.has_updates,
--             color = { fg = "#ff9e64" },
--           },
--           { "encoding" },
--           { "fileformat" },
--           { "filetype" },
--         },
--       },
--     })
--   end,
-- }
