return {
  {
    'nvim-lualine/lualine.nvim',
    optional = true,
    event = 'VeryLazy',
    opts = function(_, opts)
      -- Ensure sections exist
      opts.sections = opts.sections or {}
      opts.sections.lualine_c = opts.sections.lualine_c or {}
      opts.sections.lualine_x = opts.sections.lualine_x or {}

      -- Override lualine_c to show full path without truncation
      opts.sections.lualine_c = {
        {
          'filename',
          path = 1, -- 0 = just filename, 1 = relative path, 2 = absolute path, 3 = absolute path with tilde
          shorting_target = 0, -- 0 = disable shortening
          symbols = {
            modified = '[+]',
            readonly = '[-]',
            unnamed = '[No Name]',
          },
        }
      }

      -- Add LSP, Formatter, and Linter info
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local buf = vim.api.nvim_get_current_buf()
          local clients = vim.lsp.get_clients({ bufnr = buf })
          local linters = {}
          local formatters = {}

          -- Get active linters for current buffer
          local lint_ok, lint = pcall(require, 'lint')
          if lint_ok and lint.linters_by_ft then
            local ft = vim.bo[buf].filetype
            if ft and lint.linters_by_ft[ft] then
              linters = lint.linters_by_ft[ft]
            end
          end

          -- Get active formatters for current buffer
          local conform_ok, conform = pcall(require, 'conform')
          if conform_ok then
            local ft = vim.bo[buf].filetype
            if ft then
              local available_formatters = conform.list_formatters(buf)
              for _, formatter in ipairs(available_formatters) do
                if formatter.available then
                  table.insert(formatters, formatter.name)
                end
              end
            end
          end

          local parts = {}

          -- LSP Clients
          if #clients > 0 then
            local client_names = {}
            for _, client in ipairs(clients) do
              if client.name ~= 'null-ls' and client.name ~= 'copilot' then
                table.insert(client_names, client.name)
              end
            end
            if #client_names > 0 then
              table.insert(parts, 'LSP: ' .. table.concat(client_names, ', '))
            end
          end

          -- Formatters
          if #formatters > 0 then
            table.insert(parts, 'Formatter: ' .. table.concat(formatters, ', '))
          end

          -- Linters
          if #linters > 0 then
            table.insert(parts, 'Linter: ' .. table.concat(linters, ', '))
          end

          if #parts > 0 then
            return table.concat(parts, ' | ')
          else
            return ''
          end
        end,
        color = { fg = '#808080' },
        cond = function()
          return vim.bo.buftype == ''
        end,
      })

      return opts
    end,
  },
}
