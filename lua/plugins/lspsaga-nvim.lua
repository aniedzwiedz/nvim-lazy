return {
  "glepnir/lspsaga.nvim",
  lazy = false,
  config = function()
    require("lspsaga").setup({
      -- keybinds for navigation in lspsaga window
      move_in_saga = { prev = "<C-k>", next = "<C-j>" },
      -- use enter to open file with finder
      finder_action_keys = {
        open = "<CR>",
      },
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
  },
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
}
