return {
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
  {
    "catppuccin/nvim",
    opts = {
      transparent_background = true,
    },
  },
  {
    "nvim-telescope/telescope.nvim",
    keys = {
      -- Add a keymap to browse plugin files
      -- stylua: ignore
      {
        "<leader>fp",
        function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
        desc = "Find Plugin File",
      },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = "horizontal",
        layout_config = { prompt_position = "bottom" },
        vertical = { width = 0.8 },
        sorting_strategy = "ascending",
        winblend = 0,
      },
      pickers = {
        find_files = {
          theme = "ivy",
        },
      },
    },
  },
  { "sindrets/diffview.nvim", opts = {} },
  {
    "hrsh7th/nvim-cmp",
    optional = true,
    dependencies = {
      { "petertriho/cmp-git", opts = {} },
    },
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "git" })
    end,
  },
  {
    "stevearc/conform.nvim",
    optional = true,
    opts = {
      formatters_by_ft = {
        go = { "goimports", "gofumpt" },
      },
    },
  },
}
