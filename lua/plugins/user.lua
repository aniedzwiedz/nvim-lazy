return {
  {
    "catppuccin/nvim",
    priority = 1000,
    lazy = false,
    opts = {
      flavour = "mocha", -- latte, frappe, macchiato, mocha
      transparent_background = true, -- disables setting the background color.
      show_end_of_buffer = false, -- shows the '~' characters after the end of buffers
      integrations = {
        aerial = true,
        alpha = true,
        cmp = true,
        dashboard = true,
        flash = true,
        grug_far = true,
        gitsigns = true,
        headlines = true,
        illuminate = true,
        indent_blankline = { enabled = true },
        leap = true,
        lsp_trouble = true,
        mason = true,
        markdown = true,
        mini = true,
        native_lsp = {
          enabled = true,
          underlines = {
            errors = { "undercurl" },
            hints = { "undercurl" },
            warnings = { "undercurl" },
            information = { "undercurl" },
          },
        },
        navic = { enabled = true, custom_bg = "lualine" },
        neotest = true,
        neotree = true,
        noice = true,
        notify = true,
        semantic_tokens = true,
        telescope = true,
        treesitter = true,
        treesitter_context = true,
        which_key = true,
      },
    },
  },
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- opts = function()
    opts = function(_, opts)
      ---@type snacks.Config
      return {
        notifier = {
          enabled = true,
          timeout = 3000, -- default timeout in ms
          width = { min = 40, max = 0.4 },
          height = { min = 1, max = 0.6 },
          -- editor margin to keep free. tabline and statusline are taken into account automatically
          margin = { top = 0, right = 1, bottom = 0 },
          padding = true, -- add 1 cell of left/right padding to the notification window
          sort = { "level", "added" }, -- sort by level and time
          -- minimum log level to display. TRACE is the lowest
          -- all notifications are stored in history
          level = vim.log.levels.TRACE,
          icons = {
            error = " ",
            warn = " ",
            info = " ",
            debug = " ",
            trace = " ",
          },
          keep = function(notif)
            return vim.fn.getcmdpos() > 0
          end,
          ---@type snacks.notifier.style
          style = "compact",
          top_down = true, -- place notifications from top to bottom
          date_format = "%R", -- time format for notifications
          -- format for footer when more lines are available
          -- `%d` is replaced with the number of lines.
          -- only works for styles with a border
          ---@type string|boolean
          more_format = " ↓ %d lines ",
          refresh = 50, -- refresh at most every 50ms
        },
        dashboard = {
          width = 80,
          -- row = 20, -- dashboard position. nil for center
          -- col = 20, -- dashboard position. nil for center
          pane_gap = 4, -- empty columns between vertical panes
          enabled = true,
          preset = {
            header = [[

                      > <     ,     > <
                 .     '             '      .      .
                          __.--._          > <
                  .     .'   L   `.--._     '
                 > <    `/ c '`    \   `.
                  '     :           ;    `.    `     ,
                        |           ;      \
                       /`.     | ' /        \     .
                  '   / -.\ \  ^ ;/   _      \   > <
                     :    \`.:/ \|     `.|    ;   '
                     |     :''   '       ;    |
                     |     |`.         _/_    ;
                     :     :  `-._____/   `. /
                      \    |         :/ ,   V\
            /"\   __.--; _ :         `./ /  ; ;
           :  |\_/     |  \L  _..--.   `.L.'  |`.   __
           |  | ;`.    ; _ \\'      `.          /`+'.'`.
           |  | |      | \CT_;        `-.      ' / /   |
           |-_| |   .-'`.___.            `-.    / /    ;
           :  ; :.-'                        `-./ /.   /
            \/_/         _                     \/  `./
             "                                  `._.'
    ]],
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          },
          sections = {
            { section = "header" },
            { section = "keys", pane = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 3, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 3, padding = 1 },
            {
              pane = 2,
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = Snacks.git.get_root() ~= nil,
              -- cmd = "git log --pretty=oneline -n 5 --graph --abbrev-commit ",
              cmd = "git log --decorate -n 5 --pretty=oneline --abbrev-commit",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
            { section = "startup" },
          },
        },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = false }, -- we set this in options.lua
        terminal = { enabled = true },
        rename = { enabled = true },
        toggle = { map = LazyVim.safe_keymap_set },
        words = { enabled = true },
      }
    end,
    -- keys = {
    --   {
    --     "<leader>un",
    --     function()
    --       Snacks.notifier.hide()
    --     end,
    --     desc = "Dismiss All Notifications",
    --   },
    -- },
  },

  {
    "nvim-telescope/telescope.nvim",
    keys = {
      {
        "<leader>fp",
        function()
          require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root })
        end,
        desc = "Find Plugin File",
      },
      {
        "<leader>fP",
        "<cmd>lua require('telescope').extensions.projects.projects()<cr>",
        desc = "Projects",
      },
      {
        "<leader>fC",
        "<cmd>Telescope colorscheme<cr>",
        desc = "Colorscheme",
      },
    },
    opts = {
      defaults = {
        vimgrep_arguments = {
          "rg",
          "--color=never",
          "--no-heading",
          "--with-filename",
          "--line-number",
          "--column",
          "--smart-case",
          "--hidden",
          "--glob=!.git/",
        },
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "bottom" },
        sorting_order = "descending",
        winblend = 0,
        -- prompt_prefix = " 🔷 ",
        prompt_prefix = "   ",
        -- prompt_prefix = require("icons").ui.Telescope .. " ",
        selection_caret = "  ",
      },
      pickers = {
        find_files = {
          -- `hidden = true` will still show the inside of `.git/` as it's not `.gitignore`d.
          find_command = { "rg", "--files", "--hidden", "--glob", "!**/.git/*" },
        },
        colorscheme = {
          enable_preview = true,
        },

        lsp_references = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_definitions = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_declarations = {
          theme = "dropdown",
          initial_mode = "normal",
        },

        lsp_implementations = {
          theme = "dropdown",
          initial_mode = "normal",
        },
      },
    },
  },
  {
    "akinsho/bufferline.nvim",
    optional = true,
    opts = function(_, opts)
      if (vim.g.colors_name or ""):find("catppuccin") then
        opts.highlights = require("catppuccin.groups.integrations.bufferline").get()
      end
    end,
  },
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
