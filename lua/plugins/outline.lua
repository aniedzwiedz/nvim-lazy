return {
  {
    'hedyhli/outline.nvim',
    keys = { { '<leader>cs', '<cmd>Outline<cr>', desc = 'Toggle Outline' } },
    cmd = 'Outline',
    opts = function()
      local defaults = require('outline.config').defaults
      local opts = {
        outline_window = {
          -- Vim options for the outline window
          show_numbers = false,
          show_relative_numbers = false,
          wrap = false,
          auto_jump = true,
          show_symbol_details = true,
        },
        outline_items = {
          -- Show extra details with the symbols (lsp dependent) as virtual next
          show_symbol_details = true,
          -- Whether to highlight the currently hovered symbol and all direct parents
          highlight_hovered_item = true,
        },
        -- Options for outline guides which help show tree hierarchy of symbols
        guides = {
          enabled = true,
          markers = {
            -- It is recommended for bottom and middle markers to use the same number
            -- of characters to align all child nodes vertically.
            bottom = '└',
            middle = '├',
            vertical = '│',
          },
        },
        symbols = {
          icons = {},
          filter = LazyVim.config.kind_filter,
        },
        keymaps = {
          up_and_jump = '<up>',
          down_and_jump = '<down>',
        },
      }

      for kind, symbol in pairs(defaults.symbols.icons) do
        opts.symbols.icons[kind] = {
          icon = LazyVim.config.icons.kinds[kind] or symbol.icon,
          hl = symbol.hl,
        }
      end
      return opts
    end,
  },
  {
    'folke/trouble.nvim',
    optional = true,
    keys = {
      { '<leader>cs', false },
    },
  },
}
