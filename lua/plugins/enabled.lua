return {
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    -- event = "LazyFile",
    opts = {
      -- symbol = "▏",
      symbol = "⁝ ",
      options = {
        -- border = "both",
        indent_at_cursor = true,
        -- try_as_border = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
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
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  {
    "lukas-reineke/indent-blankline.nvim", -- NOTE: disabled.lua
    event = "LazyFile",
    config = function()
      local highlight = {
        "CursorColumn",
        "Whitespace",
      }
      require("ibl").setup({
        indent = { highlight = highlight, char = "" },
        whitespace = {
          highlight = highlight,
          remove_blankline_trail = true,
        },
        scope = { enabled = true },
      })
    end,
    opts = {
      -- scope = { enabled = false },
      exclude = {
        filetypes = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
      },
    },
    main = "ibl",
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen <cr>", desc = "Open DiffviewOpen" },
      -- ["<F4>"] = { ":DiffviewClose<cr>", desc = "Close Diff View" }, -- closing Diffview
      { "<F4>", ":DiffviewClose <cr>", desc = "Close Diff View" }, -- closing Diffview
    },
  },
  {
    "akinsho/toggleterm.nvim",
    cmd = { "ToggleTerm", "TermExec" },
    opts = {
      highlights = {
        Normal = { link = "Normal" },
        NormalNC = { link = "NormalNC" },
        NormalFloat = { link = "NormalFloat" },
        FloatBorder = { link = "FloatBorder" },
        StatusLine = { link = "StatusLine" },
        StatusLineNC = { link = "StatusLineNC" },
        WinBar = { link = "WinBar" },
        WinBarNC = { link = "WinBarNC" },
      },
      size = 10,
      on_create = function()
        vim.opt.foldcolumn = "0"
        vim.opt.signcolumn = "no"
      end,
      open_mapping = [[<F7>]],
      shading_factor = 2, -- the percentage by which to lighten terminal background, default: -30 (gets multiplied by -3 if background is light)
      direction = "float",
      auto_scroll = true, -- automatically scroll to the bottom on terminal output
      close_on_exit = true, -- close the terminal window when the process exits
      float_opts = { border = "rounded" },
    },
  }, -- file explorer
  -- {
  --   "nvim-neo-tree/neo-tree.nvim",
  --   keys = {
  --     { "<leader>E", false },
  --   },
  -- },
  {
    "lewis6991/gitsigns.nvim",
    -- event = "LazyFile",
    event = "BufEnter",
    cmd = "Gitsigns",
    config = function()
      local icons = require("config.icons")

      require("gitsigns").setup({

        signs = {
          add = { text = "▎" },
          change = { text = "▎" },
          delete = { text = "" },
          topdelete = { text = "" },
          changedelete = { text = "▎" },
          untracked = { text = "▎" },
        },
        -- signs = {
        --   add = {
        --     hl = "GitSignsAdd",
        --     text = icons.ui.BoldLineLeft,
        --     numhl = "GitSignsAddNr",
        --     linehl = "GitSignsAddLn",
        --   },
        --   change = {
        --     hl = "GitSignsChange",
        --     text = icons.ui.BoldLineLeft,
        --     numhl = "GitSignsChangeNr",
        --     linehl = "GitSignsChangeLn",
        --   },
        --   delete = {
        --     hl = "GitSignsDelete",
        --     text = icons.ui.TriangleShortArrowRight,
        --     numhl = "GitSignsDeleteNr",
        --     linehl = "GitSignsDeleteLn",
        --   },
        --   topdelete = {
        --     hl = "GitSignsDelete",
        --     text = icons.ui.TriangleShortArrowRight,
        --     numhl = "GitSignsDeleteNr",
        --     linehl = "GitSignsDeleteLn",
        --   },
        --   changedelete = {
        --     hl = "GitSignsChange",
        --     text = icons.ui.BoldLineLeft,
        --     numhl = "GitSignsChangeNr",
        --     linehl = "GitSignsChangeLn",
        --   },
        -- },

        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
      })
    end,
    -- opts = {
    --   signs = {
    --     -- add = { text = "➕" },
    --     add = { hl = "GitSignsAdd", text = "+", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
    --     -- add = { text  = "🟢" },
    --     -- change = { text ="⁉" },
    --     delete = { text = "❌" },
    --     topdelete = { text = "‾" },
    --     -- changedelete = { text = "~" },
    --     changedelete = { hl = "GitSignsChange", text = "~", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn" },
    --     untracked = { text = "❓" },
    --   },
    -- },
  },
  { "b0o/SchemaStore.nvim" },
  { "folke/neodev.nvim" },
  {
    "someone-stole-my-name/yaml-companion.nvim",
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      require("telescope").load_extension("yaml_schema")
    end,
  },

  {
    "linrongbin16/gitlinker.nvim",
    event = "BufRead",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      local wk = require("which-key")
      wk.register({
        ["<leader>gy"] = { "<cmd>GitLink<cr>", "Git link" },
        ["<leader>gY"] = { "<cmd>GitLink blame<cr>", "Git link blame" },
      })

      require("gitlinker").setup({
        message = true,
        -- mapping = {
        --   ["<leader>gY"] = {
        --     -- copy git link to clipboard
        --     action = require("gitlinker.actions").clipboard,
        --     desc = "Copy git link to clipboard",
        --   },
        --   ["<leader>gy"] = {
        --     -- open git link in browser
        --     action = require("gitlinker.actions").system,
        --     desc = "Open git link in browser",
        --   },
        -- },

        -- remote = 'github', -- force the use of a specific remote
      })
    end,
  },
  {
    "nvim-tree/nvim-web-devicons",
    event = "VeryLazy",
    config = function()
      require("nvim-web-devicons").set_icon({
        gql = {
          icon = "",
          color = "#e535ab",
          cterm_color = "199",
          name = "GraphQL",
        },
      })
    end,
  },
}
