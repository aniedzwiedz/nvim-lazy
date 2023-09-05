return {
  -- "nvim-telescope/telescope.nvim",
  -- branch = "0.1.x",
  -- dependencies = {
  --   "nvim-lua/plenary.nvim",
  --   { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  --   "nvim-tree/nvim-web-devicons",
  -- },
  -- config = function()
  --   local telescope = require("telescope")
  --   local actions = require("telescope.actions")
  --
  --   telescope.setup({
  --     defaults = {
  --       path_display = { "truncate " },
  --       mappings = {
  --         i = {
  --           ["<C-k>"] = actions.move_selection_previous, -- move to prev result
  --           ["<C-j>"] = actions.move_selection_next, -- move to next result
  --           ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
  --         },
  --       },
  --     },
  --   })
  --
  --   telescope.load_extension("fzf")
  --
  -- set keymaps
  -- local keymap = vim.keymap -- for conciseness
  --
  -- keymap.set("n", "<leader>ff", "<cmd>Telescope find_files<cr>", { desc = "Fuzzy find files in cwd" })
  -- keymap.set("n", "<leader>fr", "<cmd>Telescope oldfiles<cr>", { desc = "Fuzzy find recent files" })
  -- keymap.set("n", "<leader>fs", "<cmd>Telescope live_grep<cr>", { desc = "Find string in cwd" })
  -- keymap.set("n", "<leader>fc", "<cmd>Telescope grep_string<cr>", { desc = "Find string under cursor in cwd" })
  -- end,

  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
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
    },
    -- change some options
    opts = {
      defaults = {
        -- layout_strategy = "horizontal",
        -- layout_config = { prompt_position = "top" },
        layout_config = { vertical = { width = 0.8 } },
        -- sorting_strategy = "ascending",
        winblend = 0,
      },
      pickers = {
        find_files = {
          theme = "ivy",
        },
      },
    },
  },

  -- add telescope-fzf-native
  -- {
  --   "telescope.nvim",
  --   dependencies = {
  --     "nvim-telescope/telescope-fzf-native.nvim",
  --     build = "make",
  --     config = function()
  --       require("telescope").load_extension("fzf")
  --     end,
  --   },
  -- },
}
