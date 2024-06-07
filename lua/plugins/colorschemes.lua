return {
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      transparent_background = true,
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      term_colors = false, -- sets terminal colors (e.g. `g:terminal_color_0`)
      dim_inactive = {
        enabled = false, -- dims the background color of inactive window
        shade = "dark",
        percentage = 0.15, -- percentage of the shade to apply to the inactive window
      },
      integrations = {
        cmp = true,
        gitsigns = true,
        nvimtree = true,
        treesitter = true,
        notify = true,
        alpha = true,
        mason = true,
        which_key = true,
        native_lsp = {
          enabled = true,
          virtual_text = {
            errors = { "italic" },
            hints = { "italic" },
            warnings = { "italic" },
            information = { "italic" },
          },
          underlines = {
            errors = { "underline" },
            hints = { "underline" },
            warnings = { "underline" },
            information = { "underline" },
          },
          inlay_hints = {
            background = true,
          },
        },
        neogit = true,
        mini = {
          enabled = true,
          indentscope_color = "",
        },
      },
    },
  },
  {
    "EdenEast/nightfox.nvim",
    options = {
      -- Compiled file's destination location
      -- compile_path = vim.fn.stdpath("cache") .. "/nightfox",
      -- compile_file_suffix = "_compiled", -- Compiled file suffix
      transparent = true, -- Disable setting background
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
  -- {
  --   "oxfist/night-owl.nvim",
  --   enable = false,
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     local night_owl = require("night-owl")
  --
  --     -- 👇 Add your own personal settings here
  --     night_owl.setup({
  --       transparent_background = true,
  --       -- These are the default settings
  --       bold = false,
  --       italics = false,
  --       underline = false,
  --       undercurl = false,
  --     })
  --
  --     -- load the colorscheme here
  --     -- vim.cmd.colorscheme("night-owl")
  --   end,
  -- },
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
    "sainnhe/everforest",
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.everforest_diagnostic_line_highlight = 1
      vim.g.everforest_transparent_background = 1
      vim.g.everforest_current_word = "bold"
    end,
  },

  {
    -- https://github.com/rebelot/kanagawa.nvim
    "rebelot/kanagawa.nvim", -- You can replace this with your favorite colorscheme
    lazy = false, -- We want the colorscheme to load immediately when starting Neovim
    priority = 1000, -- Load the colorscheme before other non-lazy-loaded plugins
    opts = {
      -- Replace this with your scheme-specific settings or remove to use the defaults
      transparent = true,
      background = {
        -- light = "lotus",
        dark = "wave", -- "wave, dragon"
      },
      colors = {
        palette = {
          -- Background colors
          sumiInk0 = "#161616", -- modified
          sumiInk1 = "#181818", -- modified
          sumiInk2 = "#1a1a1a", -- modified
          sumiInk3 = "#1F1F1F", -- modified
          sumiInk4 = "#2A2A2A", -- modified
          sumiInk5 = "#363636", -- modified
          sumiInk6 = "#545454", -- modified

          -- Popup and Floats
          waveBlue1 = "#322C47", -- modified
          waveBlue2 = "#4c4464", -- modified

          -- Diff and Git
          winterGreen = "#2B3328",
          winterYellow = "#49443C",
          winterRed = "#43242B",
          winterBlue = "#252535",
          autumnGreen = "#76A56A", -- modified
          autumnRed = "#C34043",
          autumnYellow = "#DCA561",

          -- Diag
          samuraiRed = "#E82424",
          roninYellow = "#FF9E3B",
          waveAqua1 = "#7E9CD8", -- modified
          dragonBlue = "#7FB4CA", -- modified

          -- Foreground and Comments
          oldWhite = "#C8C093",
          fujiWhite = "#F9E7C0", -- modified
          fujiGray = "#727169",
          oniViolet = "#BFA3E6", -- modified
          oniViolet2 = "#BCACDB", -- modified
          crystalBlue = "#8CABFF", -- modified
          springViolet1 = "#938AA9",
          springViolet2 = "#9CABCA",
          springBlue = "#7FC4EF", -- modified
          waveAqua2 = "#77BBDD", -- modified

          springGreen = "#98BB6C",
          boatYellow1 = "#938056",
          boatYellow2 = "#C0A36E",
          carpYellow = "#FFEE99", -- modified

          sakuraPink = "#D27E99",
          waveRed = "#E46876",
          peachRed = "#FF5D62",
          surimiOrange = "#FFAA44", -- modified
          katanaGray = "#717C7C",
        },
      },
    },
    config = function(_, opts)
      require("kanagawa").setup(opts) -- Replace this with your favorite colorscheme
      -- vim.cmd("colorscheme kanagawa") -- Replace this with your favorite colorscheme

      -- Custom diff colors
      vim.cmd [[
      autocmd VimEnter * hi DiffAdd guifg=#00FF00 guibg=#005500
      autocmd VimEnter * hi DiffDelete guifg=#FF0000 guibg=#550000
      autocmd VimEnter * hi DiffChange guifg=#CCCCCC guibg=#555555
      autocmd VimEnter * hi DiffText guifg=#00FF00 guibg=#005500
    ]]

      -- Custom border colors
      vim.cmd [[
      autocmd ColorScheme * hi NormalFloat guifg=#F9E7C0 guibg=#1F1F1F
      autocmd ColorScheme * hi FloatBorder guifg=#F9E7C0 guibg=#1F1F1F
    ]]
    end,
  },
  -- {
  --   "projekt0n/github-nvim-theme",
  --   lazy = false, -- make sure we load this during startup if it is your main colorscheme
  --   priority = 1000, -- make sure to load this before all the other start plugins
  --   config = function()
  --     require("github-theme").setup {
  --       options = {
  --         hide_end_of_buffer = true, -- Hide the '~' character at the end of the buffer for a cleaner look
  --         hide_nc_statusline = true, -- Override the underline style for non-active statuslines
  --         transparent = true,
  --         dim_inactive = false, -- Non focused panes set to alternative background
  --         module_default = true, -- Default enable value for modules
  --         styles = {
  --           comments = "italic",
  --           keywords = "bold",
  --           types = "italic,bold",
  --         },
  --       },
  --     }
  --   end,
  -- },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
      -- colorscheme = "kanagawa",
      -- colorscheme = "kanagawa",
      -- colorscheme = "gruvbox",
      -- colorscheme = "everforest",
    },
  },
}
