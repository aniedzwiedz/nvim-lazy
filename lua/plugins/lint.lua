return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  opts = {
    linters_by_ft = {
      -- Web development: biome is fast and modern (replaces eslint)
      -- https://biomejs.dev/
      astro = { 'biomejs' },
      css = { 'biomejs' },
      scss = { 'biomejs' },
      graphql = { 'biomejs' },
      javascript = { 'biomejs' },
      javascriptreact = { 'biomejs' },
      json = { 'biomejs' },
      jsonc = { 'biomejs' },
      svelte = { 'biomejs' },
      typescript = { 'biomejs' },
      typescriptreact = { 'biomejs' },
      vue = { 'biomejs' },

      -- Python: ruff is much faster than pylint (written in Rust)
      -- https://github.com/astral-sh/ruff
      python = { 'ruff' },

      -- Infrastructure and DevOps
      dockerfile = { 'hadolint' },
      terraform = { 'terraform_validate', 'tflint' },
      tf = { 'terraform_validate', 'tflint' },
      ansible = { 'ansible_lint' },

      -- Configuration and markup
      yaml = { 'yamllint' },
      ['yaml.ansible'] = { 'ansible_lint' },
      ['yaml.gha'] = { 'actionlint' },
      markdown = { 'markdownlint-cli2' },

      -- Shell: shellcheck for all shell types
      sh = { 'shellcheck' },
      bash = { 'shellcheck' },
      zsh = { 'zsh' },

      -- Other languages
      groovy = { 'npm-groovy-lint' },
      puppet = { 'puppet-lint' },
      cmake = { 'cmakelint' },
      make = { 'checkmake' },
      fish = { 'fish' },
    },
    linters = {},
  },
  config = function(_, opts)
    local lint = require 'lint'

    -- Add Mason bin to PATH for linters
    local mason_bin = vim.fn.stdpath 'data' .. '/mason/bin'
    vim.env.PATH = mason_bin .. ':' .. vim.env.PATH

    lint.linters_by_ft = vim.tbl_deep_extend('force', lint.linters_by_ft or {}, opts.linters_by_ft or {})
    for name, config in pairs(opts.linters or {}) do
      lint.linters[name] = config
    end

    local function lint_current_file()
      local buf = vim.api.nvim_get_current_buf()
      local ft = vim.bo[buf].filetype
      local configured = lint.linters_by_ft[ft] or lint.linters_by_ft['_']
      if configured then
        lint.try_lint()
      end
    end

    local lint_augroup = vim.api.nvim_create_augroup('lint_on_save', { clear = true })
    
    -- Lint on save
    vim.api.nvim_create_autocmd('BufWritePost', {
      group = lint_augroup,
      callback = lint_current_file,
    })
    
    -- ADDED: Lint in insert mode (real-time linting)
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave', 'TextChanged' }, {
      group = lint_augroup,
      callback = function()
        -- Debounce to avoid too frequent linting
        vim.defer_fn(lint_current_file, 100)
      end,
    })

    vim.keymap.set('n', '<leader>l', lint_current_file, { desc = 'Trigger linting for current file' })
  end,
}
