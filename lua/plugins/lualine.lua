return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "meuter/lualine-so-fancy.nvim",
    "nvim-tree/nvim-web-devicons",
  },
  enabled = true,
  lazy = false,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    -- local icons = require("config.icons")
    local lazy_status = require "lazy.status"

    -- get schema for current buffer
    local function get_schema()
      local schema = require("yaml-companion").get_buf_schema(0)
      if schema.result[1].name == "none" then
        return ""
      end
      return schema.result[1].name
    end

    require("lualine").setup {
      options = {
        theme = "auto",
        component_separators = { left = "│", right = "│" },
        section_separators = { left = "", right = "" },
        refresh = {
          statusline = 100,
        },

        -- theme = "catppuccin",
        -- component_separators = { left = "", right = "" },
        -- section_separators = { left = "", right = "" },
        disabled_filetypes = { -- Filetypes to disable lualine for.
          disabled_filetypes = {
            statusline = { "dashboard", "alpha", "starter", "toggleterm", "spectre_panel", "neo-tree" },
            winbar = {},
          },
        },
        globalstatus = true,
        icons_enabled = true,
        -- component_separators = { left = "│", right = "│" },
      },
      sections = {
        lualine_a = {},
        lualine_b = {
          -- "fancy_branch",
          { "branch", icon = { "", align = "right" } },
          { "fancy_macro" },
        },
        lualine_c = {
          -- { "fancy_cwd", substitute_home = true },
          {
            "filename",
            path = 1, -- 2 for full path
            symbols = {
              modified = "  ",
              readonly = "  ",
              unnamed = "  ",
            },
          },
          "fancy_diff",
        },
        lualine_x = {
          { "fancy_searchcount" },
          { "fancy_diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          { "fancy_lsp_servers" },
          get_schema(),
        },
        lualine_y = {
          { "progress" },
          { "fancy_location" },
        },
        lualine_z = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
          -- { "fancy_filetype" },
          { "fileformat" },
        },
      },
      inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { "filename" },
        -- lualine_x = { "location" },
        lualine_y = {},
        lualine_z = {},
      },
      tabline = {},
      extensions = { "neo-tree", "lazy" },
    }
  end,
}
