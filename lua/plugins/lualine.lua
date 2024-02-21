return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "meuter/lualine-so-fancy.nvim",
  },
  enabled = true,
  lazy = false,
  event = { "BufReadPost", "BufNewFile", "VeryLazy" },
  config = function()
    -- local icons = require("config.icons")
    local lazy_status = require("lazy.status")

    require("lualine").setup({
      options = {
        theme = "auto",
        -- theme = "catppuccin",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
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
        },
        lualine_c = {
          {
            "filename",
            path = 1, -- 2 for full path
            symbols = {
              modified = "  ",
              readonly = "  ",
              -- unnamed = "  ",
            },
          },
          "fancy_diff",
        },
        lualine_x = {
          { "fancy_searchcount" },
          { "fancy_diagnostics", sources = { "nvim_lsp" }, symbols = { error = " ", warn = " ", info = " " } },
          "fancy_lsp_servers",
          "progress",
        },
        lualine_y = {},
        lualine_z = {
          {
            lazy_status.updates,
            cond = lazy_status.has_updates,
            color = { fg = "#ff9e64" },
          },
          { "encoding" },
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
    })
  end,
}