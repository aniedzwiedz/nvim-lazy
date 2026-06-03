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
      if ft == 'json' or ft:match 'yaml' then
        return vim.fn.expand '%:p:h'
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
      -- Biome configuration: fallback to prettier if no biome.json found
      ['biome'] = {
        require_cwd = false,
        condition = function(self, ctx)
          -- Check if biome.json or biome.jsonc exists in project root
          local root =
            vim.fs.root(ctx.buf, { 'biome.json', 'biome.jsonc', '.git' })
          if root then
            local biome_config = vim.fs.find(
              { 'biome.json', 'biome.jsonc' },
              { path = root, upward = false }
            )[1]
            if biome_config then
              return true
            end
          end
          -- Fallback: allow biome even without config for formatting
          return true
        end,
      },
      -- Ruff for Python: organize imports then format
      ['ruff_organize_imports'] = {
        command = 'ruff',
        args = {
          'check',
          '--select',
          'I',
          '--fix',
          '--stdin-filename',
          '$FILENAME',
          '-',
        },
      },
      ['ruff_format'] = {
        command = 'ruff',
        args = { 'format', '--stdin-filename', '$FILENAME', '-' },
      },
    },

    formatters_by_ft = {
      -- Python: ruff is faster and replaces black + isort
      -- https://github.com/astral-sh/ruff
      python = { 'ruff_organize_imports', 'ruff_format' },

      -- Lua
      ['lua'] = { 'stylua' },

      -- Shell scripts: shfmt for formatting (shellcheck is a linter, not formatter!)
      -- https://github.com/mvdan/sh
      sh = { 'shfmt' },
      bash = { 'shfmt' },
      zsh = { 'shfmt' },

      -- Markdown
      ['markdown'] = { 'prettier', 'markdownlint-cli2', 'markdown-toc' },
      ['markdown.mdx'] = { 'prettier', 'markdownlint', 'markdown-toc' },

      -- JavaScript/TypeScript: biome is faster than prettier
      -- https://biomejs.dev/
      javascript = { 'biome' },
      javascriptreact = { 'biome' },
      typescript = { 'biome' },
      typescriptreact = { 'biome' },

      -- JSON: biome is modern and fast
      json = { 'biome' },
      jsonc = { 'biome' },

      -- YAML: yamlfmt is fast and simple, prettier as fallback
      -- https://github.com/google/yamlfmt
      -- Note: yamlfmt needs to be installed via :MasonInstall yamlfmt
      -- Until then, prettier will be used as fallback
      yaml = { 'yamlfmt', 'prettier', stop_after_first = true },
      ['yaml.azure'] = { 'yamlfmt', 'prettier', stop_after_first = true },
      ['yaml.ansible'] = { 'yamlfmt', 'prettier', stop_after_first = true },
      ['yaml.docker-compose'] = { 'yamlfmt', 'prettier', stop_after_first = true },
      ['yaml.gitlab'] = { 'yamlfmt', 'prettier', stop_after_first = true },

      -- Infrastructure as Code
      terraform = { 'terraform_fmt' },
      tf = { 'terraform_fmt' },
      ['terraform-vars'] = { 'terraform_fmt' },
      hcl = { 'packer_fmt' },

      -- Other languages
      awk = { 'gawk' },
      eruby = { 'erb-format' },
      go = { 'goimports', 'gofumpt' },
      toml = { 'taplo' },
      xml = { 'xmllint' },
      zig = { 'zigfmt' },
      zon = { 'zigfmt' },

      -- Fallback: trim whitespace on all files without specific formatter
      ['_'] = { 'trim_whitespace' },
    },
  },
}
