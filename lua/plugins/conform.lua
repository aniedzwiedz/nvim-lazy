return {
  'stevearc/conform.nvim',
  optional = true,
  opts = {
    -- This can also be a function that returns the table.
    format_after_save = {
      lsp_format = 'fallback',
    },
    -- Set the log level. Use `:ConformInfo` to see the location of the log file.
    log_level = vim.log.levels.ERROR,
    -- Conform will notify you when a formatter errors
    notify_on_error = true,
    -- Conform will notify you when no formatters are available for the buffer
    notify_no_formatters = true,
    -- Set this to change the default values when calling conform.format()
    -- This will also affect the default values for format_on_save/format_after_save
    default_format_opts = {
      lsp_format = 'fallback',
    },
    format_on_save = false, -- Disable autoformatting on save
    formatters = {
      ['markdown-toc'] = {
        condition = function(_, ctx)
          for _, line in
            ipairs(vim.api.nvim_buf_get_lines(ctx.buf, 0, -1, false))
          do
            if line:find '<!%-%- toc %-%->' then
              return true
            end
          end
        end,
      },
      ['markdownlint-cli2'] = {
        condition = function(_, ctx)
          local diag = vim.tbl_filter(function(d)
            return d.source == 'markdownlint'
          end, vim.diagnostic.get(ctx.buf))
          return #diag > 0
        end,
      },
    },

    formatters_by_ft = {
      -- ["lua"] = { "stylua", "lua_ls" },
      python = { 'isort', 'black' },
      ['lua'] = { 'stylua' },
      -- ["sh"] = { "bashls" }, --NOTE: format with a LSP
      ['markdown'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      ['zsh'] = { 'beautysh' },
      terraform = { 'terraform_fmt' },
      tf = { 'terraform_fmt' },
      ['terraform-vars'] = { 'terraform_fmt' },
      hcl = { 'packer_fmt' },
      ['yaml.azure'] = { 'prettier' },
      -- ruby = { formatter },
      eruby = { 'erb-format' },
      go = { 'goimports', 'gofumpt' },
      -- Use the "*" filetype to run formatters on all filetypes.
      -- ['*'] = { 'codespell' },
      -- Use the "_" filetype to run formatters on filetypes that don't
      -- have other formatters configured.
      ['_'] = { 'trim_whitespace' },
    },
  },
}
