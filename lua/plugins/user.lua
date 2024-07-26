return {
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
}
