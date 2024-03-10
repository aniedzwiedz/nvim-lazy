-- TODO

-- references:
-- https://github.com/nvim-neo-tree/neo-tree.nvim
-- https://github.com/nvim-neo-tree/neo-tree.nvim/wiki/Recipes
-- if true then return {} end  -- TODO: nie dziala przechodzenie do pliku

return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  event = "VeryLazy",
  keys = {
    { "<leader>e", ":Neotree toggle left<CR>", silent = true, desc = "File Explorer" },
    -- { "<leader><tab>", ":Neotree toggle left<CR>",  silent = true, desc = "Left File Explorer" },
  },
  config = function()
    local icons = require("lazyvim.config").icons
    require("neo-tree").setup({
      close_if_last_window = true,
      sources = {
        "filesystem",
        "buffers",
        "git_status",
        -- "diagnostics",
        -- "document_symbols",
      },

      source_selector = {
        winbar = true,
        statusline = false,
        -- content_layout = "center",
        -- tabs_layout = "equal",
        -- show_separator_on_edge = true,
      },
      popup_border_style = "single",
      enable_git_status = true,
      enable_modified_markers = true,
      enable_diagnostics = true,
      sort_case_insensitive = true,
      default_component_configs = {
        indent = {
          with_markers = true,
          with_expanders = true,
        },
        modified = {
          symbol = " ",
          highlight = "NeoTreeModified",
        },
        icon = {
          folder_closed = "",
          folder_open = "",
          folder_empty = "",
          folder_empty_open = "",
        },
        git_status = {
          symbols = {
            -- Change type
            -- added = "",
            added = icons.git.added,
            deleted = icons.git.removed,
            modified = icons.git.modified,
            renamed = "",
            -- Status type
            untracked = "",
            ignored = "",
            unstaged = "",
            staged = "",
            conflict = "",
          },
        },
      },
      window = {
        position = "float",
        width = 35,
      },
      filesystem = {
        use_libuv_file_watcher = true,
        filtered_items = {
          hide_dotfiles = false,
          hide_gitignored = false,
          hide_by_name = {
            "node_modules",
          },
          never_show = {
            ".DS_Store",
            "thumbs.db",
          },
        },
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
        group_empty_dirs = false, -- when true, empty folders will be grouped together
      },
      buffers = {
        follow_current_file = {
          enabled = true, -- This will find and focus the file in the active buffer every time
          --              -- the current file is changed while the tree is open.
          leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
        },
      },
      -- event_handlers = {
      --   {
      --     event = "neo_tree_window_after_open",
      --     handler = function(args)
      --       if args.position == "left" or args.position == "right" then
      --         vim.cmd("wincmd =")
      --       end
      --     end,
      --   },
      --   {
      --     event = "neo_tree_window_after_close",
      --     handler = function(args)
      --       if args.position == "left" or args.position == "right" then
      --         vim.cmd("wincmd =")
      --       end
      --     end,
      --   },
      -- },
    })
  end,
}
