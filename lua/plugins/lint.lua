return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require('lint')

    -- Organized linter configuration by file type
    lint.linters_by_ft = {
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
    }

    -- Create autogroup for linting events
    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })

    -- Auto-lint on file events (excluding BufEnter for performance)
    vim.api.nvim_create_autocmd({ 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    -- Manual lint trigger with better keymap
    vim.keymap.set('n', '<leader>l', function()
      lint.try_lint()
    end, { desc = 'Trigger linting for current file' })
  end,
}
