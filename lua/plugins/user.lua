return {
  {
    "folke/edgy.nvim", -- NOTE: do I need it?
    optional = true,
    opts = function(_, opts)
      local edgy_idx = LazyVim.plugin.extra_idx("ui.edgy")
      local symbols_idx = LazyVim.plugin.extra_idx("editor.outline")

      if edgy_idx and edgy_idx > symbols_idx then
        LazyVim.warn(
          "The `edgy.nvim` extra must be **imported** before the `outline.nvim` extra to work properly.",
          { title = "LazyVim" }
        )
      end

      opts.right = opts.right or {}
      table.insert(opts.right, {
        title = "Outline",
        ft = "Outline",
        pinned = true,
        open = "Outline",
      })
    end,
  },
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
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    keys = {
      -- { "<leader>fP", ""<cmd> Telescope projects  <cr>", desc = "Projects" }, --NOTE: nie dziala
    },
  },
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
      local cmp = require("cmp")
      opts.window = {
        completion = cmp.config.window.bordered({
          border = {
            { "󱐋", "WarningMsg" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
        }),
        documentation = cmp.config.window.bordered({
          border = {
            { "", "DiagnosticHint" },
            { "─", "Comment" },
            { "╮", "Comment" },
            { "│", "Comment" },
            { "╯", "Comment" },
            { "─", "Comment" },
            { "╰", "Comment" },
            { "│", "Comment" },
          },
        }),
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },

      {
        "<leader>gC",
        function()
          -- require("telescope.builtin").git_bcommits(require("telescope.themes").get_ivy({}))
          require("telescope.builtin").git_bcommits()
        end,
        desc = "commits for current file ",
      },
    },

    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")
      --       local trouble = require("trouble.providers.telescope")
      --       local icons = require("config.icons")
      --
      local function formattedName(_, path)
        local tail = vim.fs.basename(path)
        local parent = vim.fs.dirname(path)
        if parent == "." then
          return tail
        end
        return string.format("%s\t\t%s", tail, parent)
      end

      telescope.setup({

        defaults = {
          hidden = false,
          -- layout_strategy = "horizontal",
          layout_strategy = "vertical",
          layout_config = { prompt_position = "top", vertical = { width = 0.85 } },
          -- layout_config = {
          --   vertical = {
          --     width = 0.75,
          --   },
        },
        sorting_strategy = "ascending",
        winblend = 0,

        pickers = {

          find_files = {
            -- hidden = true,
            find_command = {
              "rg",
              "--files",
              "--hidden",
              "--line-number",
              "-g",
              "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}",
            },
            layout_config = {
              -- height = 0.70,
            },
          },
          live_grep = {
            additional_args = { "--hidden" },
          },
          grep_string = {
            additional_args = { "--hidden" },
          },

          -- git_status = {
          --   git_icons = {
          --     added = " ",
          --     changed = " ",
          --     copied = " ",
          --     deleted = " ",
          --     renamed = "➡",
          --     unmerged = " ",
          --     untracked = " ",
          --   },
          -- },

          buffers = {
            path_display = formattedName,
            mappings = {
              i = {
                ["<c-d>"] = actions.delete_buffer,
              },
              n = {
                ["<c-d>"] = actions.delete_buffer,
              },
            },
            previewer = false,
            initial_mode = "normal",
            -- theme = "dropdown",
            layout_config = {
              height = 0.4,
              width = 0.6,
              prompt_position = "top",
              preview_cutoff = 120,
            },
            lsp_references = {
              show_line = false,
              previewer = true,
            },
            treesitter = {
              show_line = false,
              previewer = true,
            },
            colorscheme = {
              enable_preview = true,
            },
          },
        },
      })
    end,
  },
}
