return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-telescope/telescope-frecency.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "nvim-telescope/telescope-fzf-native.nvim",
      "nvim-telescope/telescope-github.nvim",
      build = "make",
    },
    keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fP",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
      {
        "<leader>ff",
        "<cmd>Telescope frecency workspace=CWD theme=ivy<cr>",
        desc = "Find Files (frecency)",
      },
      { "<leader>gC", "<cmd>AdvancedGitSearch diff_commit_file<cr>", desc = "Commits for [C]urrent file" },
    },

    config = function(_, opts)
      require("telescope").load_extension("frecency")
      -- require("telescope").load_extension("fzf")
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

          extensions = {
            gh = {},
            advanced_git_search = {
              diff_plugin = "diffview",
            },
            frecency = {
              show_scores = true, -- Default: false
              -- If `true`, it shows confirmation dialog before any entries are removed from the DB
              -- If you want not to be bothered with such things and to remove stale results silently
              -- set db_safe_mode=false and auto_validate=true
              --
              -- This fixes an issue I had in which I couldn't close the floating
              -- window because I couldn't focus it
              db_safe_mode = false,       -- Default: true
              -- If `true`, it removes stale entries count over than db_validate_threshold
              auto_validate = true,       -- Default: true
              -- It will remove entries when stale ones exist more than this count
              db_validate_threshold = 10, -- Default: 10
              -- Show the path of the active filter before file paths.
              -- So if I'm in the `dotfiles-latest` directory it will show me that
              -- before the name of the file
              show_filter_column = false, -- Default: true
              -- I declare a workspace which I will use when calling frecency if I
              -- want to search for files in a specific path
              -- workspaces = {
              --   ["neobean_plugins"] = "$HOME/.config/LazyVim/",
              -- },
            },

          },
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
            -- theme = "ivy",
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
