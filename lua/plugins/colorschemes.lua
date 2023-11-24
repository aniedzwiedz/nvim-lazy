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
    "EdenEast/nightfox.nvim",
    options = {
      -- Compiled file's destination location
      -- compile_path = vim.fn.stdpath("cache") .. "/nightfox",
      -- compile_file_suffix = "_compiled", -- Compiled file suffix
      transparent = false, -- Disable setting background
      terminal_colors = true, -- Set terminal colors (vim.g.terminal_color_*) used in `:terminal`
      dim_inactive = true, -- Non focused panes set to alternative background
      module_default = true, -- Default enable value for modules
      colorblind = {
        enable = false, -- Enable colorblind support
        simulate_only = false, -- Only show simulated colorblind colors and not diff shifted
        severity = {
          protan = 1, -- Severity [0,1] for protan (red)
          deutan = 0, -- Severity [0,1] for deutan (green)
          -- tritan = 0, -- Severity [0,1] for tritan (blue)
        },
      },
      styles = { -- Style to be applied to different syntax groups
        comments = "undercurl", -- Value is any valid attr-list value `:help attr-list`
        conditionals = "NONE",
        constants = "NONE",
        functions = "bold",
        keywords = "NONE",
        numbers = "NONE",
        operators = "NONE",
        strings = "NONE",
        types = "NONE",
        variables = "NONE",
      },
      inverse = { -- Inverse highlight for different types
        match_paren = false,
        visual = false,
        search = false,
      },
      modules = { -- List of various plugins and additional options
        -- ...
      },
    },
    palettes = {
      duskfox = {
        bg1 = "#000000", -- Black background
        bg0 = "#1d1d2b", -- Alt backgrounds (floats, statusline, ...)
        bg3 = "#121820", -- 55% darkened from stock
        sel0 = "#131b24", -- 55% darkened from stock
      },
    },
    specs = {
      all = {
        inactive = "bg0", -- Default value for other styles
      },
      duskfox = {
        inactive = "#090909", -- Slightly lighter then black background
      },
    },
    groups = {
      all = {
        NormalNC = { fg = "fg1", bg = "inactive" }, -- Non-current windows
      },
    },
  }, -- lazy

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
  {
    "LunarVim/primer.nvim",
    lazy = false, -- make sure we load this during startup if it is your main colorscheme
    priority = 1000, -- make sure to load this before all the other start plugins
  },

  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "primer_dark",
      -- colorscheme = "nord",
    },
  },
}
