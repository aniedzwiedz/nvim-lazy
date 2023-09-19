return {

  -- require("notify").setup({
  --   background_colour = "#000000",
  -- }),
  --
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
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "gruvbox",
    },
  },

  {
    "lukas-reineke/indent-blankline.nvim",
    event = { "BufReadPost", "BufNewFile" },
    opts = {
      -- char = "▏",
      char = "│",
      filetype_exclude = {
        "help",
        "alpha",
        "dashboard",
        "neo-tree",
        "Trouble",
        "lazy",
        "mason",
        "notify",
        "toggleterm",
        "lazyterm",
      },
      show_trailing_blankline_indent = true,
      show_current_context = false,
    },
  },

  {
    "stevearc/dressing.nvim",
    event = "VeryLazy",
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, {
          "terraform",
          "hcl",
          "tsx",
          "typescript",
          "dockerfile",
          "bash",
          "c",
          "html",
          "javascript",
          "jsdoc",
          "json",
          "lua",
          "luadoc",
          "luap",
          "markdown",
          "markdown_inline",
          "python",
          "query",
          "regex",
          "typescript",
          "vim",
          "vimdoc",
          "yaml",
          "ruby",
        })
      end
    end,
  },

  {
    "SmiteshP/nvim-navic",
    lazy = true,
    init = function()
      vim.g.navic_silence = true
      require("lazyvim.util").on_attach(function(client, buffer)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, buffer)
        end
      end)
    end,
    opts = function()
      return {
        separator = " ",
        highlight = true,
        depth_limit = 5,
        icons = require("lazyvim.config").icons.kinds,
      }
    end,
  },
  -- Use <tab> for completion and snippets (supertab)
  -- first: disable default <tab> and <s-tab> behavior in LuaSnip
  {
    "L3MON4D3/LuaSnip",
    keys = function()
      return {}
    end,
  },
  {
    "nvim-neotest/neotest",
    optional = true,
    dependencies = {
      "olimorris/neotest-rspec",
    },
    opts = {
      adapters = {
        ["neotest-rspec"] = {
          -- NOTE: By default neotest-rspec uses the system wide rspec gem instead of the one through bundler
          -- rspec_cmd = function()
          --   return vim.tbl_flatten({
          --     "bundle",
          --     "exec",
          --     "rspec",
          --   })
          -- end,
        },
      },
    },
  },

  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen <cr>", desc = "Open DiffviewOpen" },
      -- ["<F4>"] = { ":DiffviewClose<cr>", desc = "Close Diff View" }, -- closing Diffview
      { "<F4>", ":DiffviewClose <cr>", desc = "Close Diff View" }, -- closing Diffview
    },
  },

  {
    "phaazon/hop.nvim",
    branch = "v2",
    event = "BufRead",
    -- keys = {
    --   { "<leader>h", "<cmd>HopChar1 <cr>", desc = "Search with HOP char1" },
    -- },
    config = function()
      require("hop").setup()
      vim.api.nvim_set_keymap("n", "S", ":HopChar1<cr>", { silent = true })
      -- vim.api.nvim_set_keymap("n", "F", ":HopWord<cr>", { silent = true })
    end,
  },

  { "ruifm/gitlinker.nvim" },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = function(_, opts)
    vim.api.nvim_set_keymap(
      "n",
      "<leader>gB",
      '<cmd>lua require"gitlinker".get_repo_url({action_callback = require"gitlinker.actions".open_in_browser})<cr>',
      { silent = true }
    )

    gitlinker.setup({
      opts = {
        callbacks = {
          -- ["git.comcast.com"] = require("gitlinker.hosts").get_github_type_url,
          ["git.gtech.com"] = require("gitlinker.hosts").get_github_type_url,
        },
        -- remote = 'github', -- force the use of a specific remote
        -- adds current line nr in the url for normal mode
        add_current_line_on_normal_mode = true,
        -- callback for what to do with the url
        action_callback = require("gitlinker.actions").copy_to_clipboard,
        -- print the url after performing the action
        print_url = true,
        -- mapping to call url generation
        -- mappings = "<leader>gy",
      },
    })
  end,
}
