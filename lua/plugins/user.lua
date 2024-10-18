-- stylua: ignore
-- if true then return {} end

return {
  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    ft = { "markdown" },
    build = function() vim.fn["mkdp#util#install"]() end,
  },
  -- install with yarn or npm NOTE: https://github.com/iamcco/markdown-preview.nvim 
-- {
--   "iamcco/markdown-preview.nvim",
--   cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
--   build = "cd app && yarn install",
--   init = function()
--     vim.g.mkdp_filetypes = { "markdown" }
--   end,
--   ft = { "markdown" },
-- },


  { "mfussenegger/nvim-ansible" },
  {
    "mistricky/codesnap.nvim",
    build = "make build_generator",
    keys = {
      { "<leader>cz", "<cmd>CodeSnap<cr>",     mode = "x", desc = "Save selected code snapshot into clipboard" },
      { "<leader>cZ", "<cmd>CodeSnapSave<cr>", mode = "x", desc = "Save selected code snapshot in /mnt/c/Users/aniedzwiedz/Pictures/codesnap" },
    },
    opts = {
      save_path = "/mnt/c/Users/aniedzwiedz/Pictures/codesnap",
      has_breadcrumbs = true,
      show_workspace = true,
      has_line_number = true,
      bg_color = "#535c68",
      bg_theme = "bamboo",
      bg_padding = 10,
      bg_x_padding = 122,
      bg_y_padding = 82,
      watermark = "",
    },
  },
  {
    "nvim-lualine/lualine.nvim",
    optional = true,
    event = "VeryLazy",
    opts = function(_, opts)
      if not vim.g.trouble_lualine then
        table.insert(opts.sections.lualine_a, {
          function()
            return require("nvim-navic").get_location()
          end,
          cond = function()
            return package.loaded["nvim-navic"] and require("nvim-navic").is_available()
          end,
        })
      end
    end,
  },

  {
    "MagicDuck/grug-far.nvim",
    keys =
    {
      { "<leader>sr", "<cmd>lua require('grug-far').open({ prefills = { search = vim.fn.expand('<cword>') } })<CR>",             desc = "[r]eplace current word" },
      { "<leader>sR", "<cmd>lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand(' % ') } })<CR>", desc = "[R]eplace selected word" },
      -- { "<leader>sr", "<cmd>:lua require('grug-far').with_visual_selection({ prefills = { paths = vim.fn.expand('%') } })<CR>", desc = "[r]eplace current word" },
    }
  },

  {
    "ahmedkhalf/project.nvim",
    keys = {
      { "<leader>fp", "<cmd>Telescope projects<CR>", desc = "Find [p]rojects" },
    },
    config = function()
      require("project_nvim").setup({
        -- your configuration comes here
        -- or leave it empty to use the default settings
        -- refer to the configuration section below
        sync_root_with_cwd = true,
        active = true,
        on_config_done = nil,
        manual_mode = false,
        detection_methods = { "pattern" },
        ignore_lsp = {},
        exclude_dirs = {},
        show_hidden = false,
        silent_chdir = true,
        scope_chdir = "global",
        patterns = {
          ".git",
          -- "_darcs",
          -- ".hg",
          -- ".bzr",
          -- ".svn",
          -- "Makefile",
          "package.json",
          "!.git/worktrees",
          "!=extras",
          "!^fixtures",
          "_darcs", ".hg", ".bzr", ".svn",
          "!build/env.sh",
        },
        datapath = vim.fn.stdpath("data"),
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
      })
    end,
  },
  -- {
  --   "folke/edgy.nvim", -- NOTE: do I need it?
  --   optional = true,
  --   opts = function(_, opts)
  --     local edgy_idx = LazyVim.plugin.extra_idx("ui.edgy")
  --     local symbols_idx = LazyVim.plugin.extra_idx("editor.outline")
  --
  --     if edgy_idx and edgy_idx > symbols_idx then
  --       LazyVim.warn(
  --         "The `edgy.nvim` extra must be **imported** before the `outline.nvim` extra to work properly.",
  --         { title = "LazyVim" }
  --       )
  --     end
  --
  --     opts.right = opts.right or {}
  --     table.insert(opts.right, {
  --       title = "Outline",
  --       ft = "Outline",
  --       pinned = true,
  --       open = "Outline",
  --     })
  --   end,
  -- },
  {
    "hedyhli/outline.nvim",
    lazy = true,
    cmd = { "Outline", "OutlineOpen" },
    keys = { -- Example mapping to toggle outline
      { "<leader>cs", "<cmd>Outline<CR>", desc = "Toggle outline" },
    },
    opts = {
      -- Your setup opts here
    },
  },
  {
    "folke/trouble.nvim",
    optional = true,
    keys = {
      { "<leader>cs", false },
    },
  },
  -- {
  --   "nvim-telescope/telescope.nvim",
  --   optional = true,
  --   keys = {
  --     -- { "<leader>fP", ""<cmd> Telescope projects  <cr>", desc = "Projects" }, --NOTE: nie dziala
  --   },
  -- },
  {
    "mfussenegger/nvim-ansible",
    optional = true,
    keys = {
      { "<leader>ta", false },
    },
  },
  -- override nvim-cmp and add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "stylua",
        "yamllint",
        "pylint",
        "beautysh",
        "actionlint",
        "hadolint",
        "shfmt",
        "selene",
        "shellcheck",
        "sql-formatter",
        "gopls",
        "tflint",
        -- "gitlab_ci_ls",  -- requires rustc 1.74
      },
    },
  },
  {
    "yasuhiroki/github-actions-yaml.vim"
  },

  {
    "vuki656/package-info.nvim",
    ft = "json",
    dependencies = { "MunifTanjim/nui.nvim" },
    config = function()
      require("package-info").setup({
        autostart = false,
        package_manager = "npm",
        colors = {
          outdated = "#db4b4b",
        },
        hide_up_to_date = true,
      })
    end,
  },
  -- UI
  {
    "rcarriga/nvim-notify",
    opts = {
      timeout = 1600,
      render = "wrapped-compact",
      stages = "slide",
      max_height = function()
        return math.floor(vim.o.lines * 0.75)
      end,
      max_width = function()
        return math.floor(vim.o.columns * 0.25)
      end,
      on_open = function(win)
        vim.api.nvim_win_set_config(win, { zindex = 100 })
      end,
    },
  },

  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      preset = "helix",
      plugins = {
        marks = true,
        registers = true,
        spelling = {
          enabled = true,
          suggestions = 30,
        },
        presets = {
          operators = false,
          motions = false,
          text_objects = false,
          windows = false,
          nav = false,
          z = false,
          g = false,
        },
      },
      win = {
        border = "rounded",
        no_overlap = false,
        padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
        title = false,
        title_pos = "center",
        zindex = 1000,
      },
      -- ignore_missing = true,
      show_help = false,
      show_keys = false,
      disable = {
        buftypes = {},
        filetypes = { "TelescopePrompt" },
      },

    }
  },

}
