return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    linters_by_ft = {
      -- Web development
      javascript = { 'eslint_d' },
      javascriptreact = { 'eslint_d' },
      typescript = { 'eslint_d' },
      typescriptreact = { 'eslint_d' },
      svelte = { 'eslint_d' },

      -- Infrastructure and DevOps
      dockerfile = { 'hadolint' },
      terraform = { 'terraform_validate' },
      tf = { 'terraform_validate' },
      ansible = { 'ansible_lint' },

      -- Configuration and markup
      yaml = { 'yamllint' },
      ['yaml.gha'] = { 'actionlint' },
      json = { 'jsonlint' },
      markdown = { 'markdownlint-cli2' },

      -- Programming languages
      python = { 'pylint' },
      groovy = { 'npm-groovy-lint' },
      puppet = { 'puppet-lint' },

      -- Build systems
      cmake = { 'cmakelint' },
      make = { 'checkmake' },

      -- Shell
      fish = { 'fish' },
      zsh = { 'zsh' },
    },
    linters = {},
  },
  config = function(_, opts)
    local lint = require 'lint'
    lint.linters_by_ft = vim.tbl_deep_extend('force', lint.linters_by_ft or {}, opts.linters_by_ft or {})
    lint.linters = vim.tbl_deep_extend('force', lint.linters or {}, opts.linters or {})

    local function lint_current_file()
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.bo[buf].filetype
      local configured = lint.linters_by_ft[ft] or lint.linters_by_ft['_']
      if configured then
        lint.try_lint()
      end
    end

    local lint_augroup = vim.api.nvim_create_augroup('lint_on_save', { clear = true })
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = lint_augroup,
      callback = lint_current_file,
    })

    vim.keymap.set('n', '<leader>l', lint_current_file, { desc = 'Trigger linting for current file' })
  end,
}
