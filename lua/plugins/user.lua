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
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = "emoji" })
    end,
  },
}
