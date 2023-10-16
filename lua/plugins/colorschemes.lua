return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = false,
        mini = false,
      },
    },
  },

  {
    "gbprod/nord.nvim",
    opts = {
      transparent = true,
      terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
      diff = { mode = "bg" }, -- enables/disables colorful backgrounds when used in diff mode. values : [bg|fg]
      borders = false, -- Enable the border between verticaly split windows visible
      errors = { mode = "bg" }, -- Display mode for errors and diagnostics
      styles = {
        -- Style to be applied to different syntax groups
        -- Value is any valid attr-list value for `:help nvim_set_hl`
        comments = { italic = true },
        keywords = { bold = true },
        functions = {},
        variables = {},

        -- To customize lualine/bufferline
        bufferline = {
          current = {},
          modified = { italic = true },
        },
      },
    },
  },

  {
    "ellisonleao/gruvbox.nvim",
    opts = {
      undercurl = true,
      underline = true,
      bold = true,
      italic = {
        strings = true,
        comments = true,
        operators = false,
        folds = true,
      },
      strikethrough = true,
      invert_selection = false,
      invert_signs = false,
      invert_tabline = false,
      invert_intend_guides = false,
      inverse = true, -- invert background for search, diffs, statuslines and errors
      contrast = "soft", -- can be "hard", "soft" or empty string
      palette_overrides = {},
      overrides = {
        -- SignColumn = { bg = "#ff9900" },
      },
      dim_inactive = false,
      transparent_mode = true,
    },
  },
  {
    "folke/tokyonight.nvim",
    opts = {
      transparent = true,
      styles = {
        sidebars = "transparent",
        floats = "transparent",
      },
    },
  },
  {
    "hardhackerlabs/theme-vim",
    name = "hardhacker",
    lazy = false,
    -- priority = 1000,
    config = function()
      vim.g.hardhacker_darker = 0
      vim.g.hardhacker_hide_tilde = 1
      vim.g.hardhacker_keyword_italic = 1
      -- vim.cmd("colorscheme hardhacker")
    end,
  },

  { "LunarVim/primer.nvim" },
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "gruvbox",
      colorscheme = "nord",
    },
  },

  {
    "nvim-lualine/lualine.nvim",
    -- options = { theme = "ayu_dark" },
    options = { theme = "nord" },
  },
}
