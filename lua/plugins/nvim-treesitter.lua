return {
  'nvim-treesitter/nvim-treesitter',
  event = 'VeryLazy',
  dependencies = {
    -- https://github.com/nvim-treesitter/nvim-treesitter-textobjects
    'nvim-treesitter/nvim-treesitter-textobjects',
  },

  -- build = ":TSUpdate",
  opts = {
    indent = { enable = true },
    auto_install = true, -- automatically install syntax support when entering new file type buffer
    autotag = {
      enable = true,
    },

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = true,
    },
    ensure_installed = {
      { 'git_config', 'gitcommit', 'git_rebase', 'gitignore', 'gitattributes', 'lua' },
    },
  },

  config = function(_, opts)
    local configs = require 'nvim-treesitter.configs'
    configs.setup(opts)
  end,

  -- opts = function(_, opts)  -- NOTE: dodatkowe opcje konfigu
  --   -- add tsx and treesitter
  --   vim.list_extend(opts.ensure_installed, {
  --     "tsx",
  --     "typescript",
  --   })
  -- end,
}
