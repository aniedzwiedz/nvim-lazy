return {
  'nvimtools/none-ls.nvim',
  event = { 'BufReadPre', 'BufNewFile' },
  dependencies = {
    'jay-babu/mason-null-ls.nvim',
    'nvim-lua/plenary.nvim',
    'nvimtools/none-ls-extras.nvim',
    'gbprod/none-ls-shellcheck.nvim',
  },
  optional = true,
  keys = {
    { '<leader>cN', '<cmd>NullLsInfo<CR>', desc = 'NullLsInfo' },
  },
  opts = function(_, opts)
    local null_ls = require 'null-ls'
    local mason_null_ls = require 'mason-null-ls'

    -- require("null-ls").register(require "none-ls-shellcheck.diagnostics")
    require('null-ls').register(require 'none-ls-shellcheck.code_actions')

    mason_null_ls.setup {
      ensure_installed = {
        'prettier', -- prettier formatter
        -- "stylua", -- lua formatter
        'eslint_d', -- js linter
        -- "golangci_lint", -- go linter
        'terraform_fmt', -- terraform formatter
        'terraform_validate', -- terraform linter
        'shellcheck', -- shell linter
        'yamllint', -- yaml linter
        'buf', -- buf formatter
        'shfmt', -- shell formatter
        -- "gofumpt", -- go formatter
        'yamlfmt', -- yaml formatter
        -- "spell", -- spell checker
        -- "black", -- python formatter
      },
    }

    opts.sources = vim.list_extend(opts.sources or {}, {
      -- null_ls.builtins.formatting.terraform_fmt, --  INFO: set via LazyExtra
      -- null_ls.builtins.formatting.prettier,
      -- null_ls.builtins.formatting.yamlfmt,
      -- null_ls.builtins.diagnostics.terraform_validate, --  INFO: set via LazyExtra
      -- null_ls.builtins.diagnostics.selene,
      null_ls.builtins.diagnostics.npm_groovy_lint,
      -- null_ls.builtins.diagnostics.markdownlint_cli2,
      null_ls.builtins.diagnostics.yamllint,
      null_ls.builtins.code_actions.refactoring,
      null_ls.builtins.code_actions.gitsigns,
    })
  end,
}
