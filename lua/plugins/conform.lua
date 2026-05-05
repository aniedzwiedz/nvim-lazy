return {
  'stevearc/conform.nvim',
  optional = true,
  opts = {
    -- This can also be a function that returns the table.
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
    -- Respect .editorconfig files in the workspace
    exec_path = function()
      local ft = vim.bo.filetype
      if ft == 'json' or ft:match('yaml') then
        return vim.fn.expand('%:p:h')
      end
    end,
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
      ['prettier'] = {
        args = { '--parser', 'yaml', '--prose-wrap', 'preserve' },
      },
    },

    formatters_by_ft = {
      -- ["lua"] = { "stylua", "lua_ls" },
      python = { 'isort', 'black' },
      awk = { 'gawk' },
      ['lua'] = { 'stylua' },
      -- ["sh"] = { "bashls" }, --NOTE: format with a LSP
      ['markdown'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      -- ['markdown.mdx'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      ['markdown.mdx'] = { 'prettier', 'markdownlint', 'markdown-toc' },
      -- ['zsh'] = { 'beautysh' },
      tf = { 'terraform_fmt' },
      ['terraform-vars'] = { 'terraform_fmt' },
      hcl = { 'packer_fmt' },
      ['yaml.azure'] = { 'yamlfmt' },
      yaml = { 'yamlfmt', 'prettier' },
      editorconfig = { 'trim_whitespace' },
      -- ruby = { formatter },
      sh = { 'shellcheck' },
      -- https://www.terraform.io/docs/cli/commands/fmt.html
      -- https://opentofu.org/docs/cli/commands/fmt/  NOTE: This is an alternative `tofu_fmt`
      terraform = { 'terraform_fmt' },
      -- https://github.com/stedolan/jq
      jq = { 'jq' },
      -- https://github.com/rhysd/fixjson
      json = { 'fixjson' },

      -- https://github.com/tamasfe/taplo
      toml = { 'taplo' },
      -- http://xmlsoft.org/xmllint.html
      xml = { 'xmllint' },
      -- https://github.com/mikefarah/yq
      yq = { 'yq' },
      -- https://github.com/ziglang/zig
      zig = { 'zigfmt' },
      zon = { 'zigfmt' },
      -- https://github.com/koalaman/shellcheck
      zsh = { 'shellcheck' },
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
