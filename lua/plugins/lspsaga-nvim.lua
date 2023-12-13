return {
  "glepnir/lspsaga.nvim",
  dependencies = {
    "simrat39/rust-tools.nvim",
    "nvim-treesitter/nvim-treesitter",
  },
  lazy = false,
  config = function()
    require("lspsaga").setup({
      -- keybinds for navigation in lspsaga window
      move_in_saga = { prev = "<C-k>", next = "<C-j>" },
      -- use enter to open file with finder
      finder_action_keys = {
        open = "<CR>",
      },
      -- ui = {
      --   border = "rounded",
      -- },
      -- use enter to open file with definition preview
      definition_action_keys = {
        edit = "<CR>",
      },
    })
  end,
  keys = {
    { "<leader>cN", "<cmd>Lspsaga diagnostic_jump_next<cr>", desc = "Lspsaga diagnostic_jump_next" },
    { "<leader>cP", "<cmd>Lspsaga peek_definition<cr>", desc = "Lspsaga peek_definition" },
    { "<leader>cK", "<cmd>Lspsaga hover_doc<cr>", desc = "Lspsaga hover_doc" },
    { "<leader>cA", "<cmd>Lspsaga code_action<cr>", desc = "Lspsaga code_action" },
    { "<leader>cO", "<cmd>Lspsaga outline<cr>", desc = "Lspsaga outline" },
  },
}
