return {
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
        "<leader>fP",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },

      { "<leader>gC", "<cmd>AdvancedGitSearch diff_commit_file<cr>", desc = "Commits for [C]urrent file" },
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

          extensions = {
            advanced_git_search = {
              diff_plugin = "diffview",
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
