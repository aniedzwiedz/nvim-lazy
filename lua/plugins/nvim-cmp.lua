
-- stylua: ignore
if true then return {} end

return {
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      {
        'Saecki/crates.nvim',
        event = { 'BufRead Cargo.toml' },
        opts = {
          -- src = {
          --   cmp = { enabled = true },
          -- },
        },
      },
      'hrsh7th/cmp-nvim-lsp',
      'hrsh7th/cmp-emoji',
      'hrsh7th/cmp-buffer',
      'hrsh7th/cmp-path',
      'hrsh7th/cmp-cmdline',
      'hrsh7th/cmp-nvim-lua',
      'onsails/lspkind.nvim', -- Adds vscode-like pictograms
      'rafamadriz/friendly-snippets',
      'petertriho/cmp-git',
      { 'L3MON4D3/LuaSnip', build = 'make install_jsregexp' },
      'saadparwaiz1/cmp_luasnip',
      {
        -- Buffer completion source with fuzzy
        'tzachar/cmp-fuzzy-buffer',
        dependencies = { 'fuzzy' },
      },
      { 'FelipeLema/cmp-async-path' }, -- Path completion source

      {
        -- Abstract layer for fuzzy finder
        'tzachar/fuzzy.nvim',
        name = 'fuzzy',
      },
      {
        -- Path completion source with fuzzy
        'tzachar/cmp-fuzzy-path',
        dependencies = { 'fuzzy' },
      },
      -- {
      --   "Exafunction/codeium.nvim",
      --   cmd = "Codeium",
      --   build = ":Codeium Auth",
      --   opts = {},
      -- },
    },
    -- config = function()
    --   vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    --   vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
    --   vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
    --   vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })
    --
    --   local cmp = require("cmp")
    --   local luasnip = require("luasnip")
    --   local lspkind = require("lspkind")
    --
    --   local icons = require("config.icons")
    --   -- mapping = cmp.mapping.preset.insert({
    --   --   ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
    --   --   ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
    --   --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
    --   --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
    --   --   ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
    --   --   ["<C-e>"] = cmp.mapping.abort(), -- close completion window
    --   --   ["<CR>"] = cmp.mapping.confirm({ select = false }),
    --   -- }),
    -- end,
    -- ---@param opts cmp.ConfigSchema
    -- opts = function(_, opts)
    -- --   local cmp = require("cmp")
    -- --   opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    --   table.insert(opts.sources, 1, {
    --     name = "codeium",
    --     group_index = 1,
    --     priority = 100,
    --   })
    -- end,

    -- dependencies = {
    --   "onsails/lspkind.nvim",
    --   "hrsh7th/cmp-emoji",
    --   {
    --     "L3MON4D3/LuaSnip",
    --     -- follow latest release.
    --     version = "2.*", -- Replace <CurrentMajor> by the latest released major (first number of latest release)
    --     -- install jsregexp (optional!).
    --     build = "make install_jsregexp",
    --   },
    -- },

    opts = function(_, opts)
      local cmp = require 'cmp'
      local lspkind = require 'lspkind'
      local compare = require 'cmp.config.compare'
      local luasnip = require 'luasnip'
      lspkind.init {}

      require('luasnip/loaders/from_vscode').lazy_load()
      -- require('luasnip.loaders.from_vscode').load { paths = { './snippets/' } } -- Load snippets from my-snippets folder

      local has_words_before = function()
        local line, col = unpack(vim.api.nvim_win_get_cursor(0))
        return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      end

      local cmp_default_sources = {
        -- { name = 'codeium', group_index = 1, priority = 100 },
        { name = 'nvim_lsp', group_index = 2 },
        { name = 'luasnip', group_index = 3 },
        {
          name = 'fuzzy_buffer',
          group_index = 4,
          option = {
            get_bufnrs = function()
              local bufs = {}
              for _, buf in ipairs(vim.api.nvim_list_bufs()) do
                local buftype = vim.api.nvim_buf_get_option(buf, 'buftype')
                if buftype ~= 'nofile' and buftype ~= 'prompt' then
                  bufs[#bufs + 1] = buf
                end
              end
              return bufs
            end,
          },
        },
        { name = 'async_path', group_index = 6 },
        { name = 'dynamic', group_index = 8 },
        { name = 'fuzzy_path', group_index = 9, option = { fd_timeout_msec = 200 } },
      }

      vim.api.nvim_set_hl(0, 'CmpGhostText', { link = 'Comment', default = true })

      -- opts.snippet = {
      --   expand = function(args)
      --     require('luasnip').lsp_expand(args.body)
      --   end,
      -- }
      -- table.insert(opts.sources, { name = 'luasnip' })

      -- local has_words_before = function()
      --   unpack = unpack or table.unpack
      --   local line, col = unpack(vim.api.nvim_win_get_cursor(0))
      --   return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match '%s' == nil
      -- end

      -- opts.mapping = vim.tbl_extend('force', opts.mapping, {
      --   ['<Tab>'] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       -- You could replace select_next_item() with confirm({ select = true }) to get VS Code autocompletion behavior
      --       cmp.select_next_item()
      --     elseif vim.snippet.active { direction = 1 } then
      --       vim.schedule(function()
      --         vim.snippet.jump(1)
      --       end)
      --     elseif has_words_before() then
      --       cmp.complete()
      --     else
      --       fallback()
      --     end
      --   end, { 'i', 's' }),
      --   ['<S-Tab>'] = cmp.mapping(function(fallback)
      --     if cmp.visible() then
      --       cmp.select_prev_item()
      --     elseif vim.snippet.active { direction = -1 } then
      --       vim.schedule(function()
      --         vim.snippet.jump(-1)
      --       end)
      --     else
      --       fallback()
      --     end
      --   end, { 'i', 's' }),
      -- })

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = 'emoji' } }))

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      -- cmp.setup.cmdline(':', {
      --   mapping = cmp.mapping.preset.cmdline(),
      --   sources = cmp.config.sources({
      --     { name = 'path' },
      --   }, {
      --     { name = 'cmdline' },
      --   }),
      -- })
      -- NOTE: git@github.com:dynamotn/neovim-config.git
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'cmdline', group_index = 1 },
          { name = 'fuzzy_path', group_index = 2 },
        },
        sorting = {
          comparators = {
            compare.offset,
            compare.exact,
            compare.scopes,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
            require 'cmp_fuzzy_path.compare',
          },
        },
      })
      -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline({ '/', '?' }, {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'fuzzy_buffer' },
        },
        sorting = {
          comparators = {
            compare.offset,
            compare.exact,
            compare.scopes,
            compare.score,
            compare.recently_used,
            compare.locality,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
            require 'cmp_fuzzy_path.compare',
          },
        },
      })

      -- NOTE: https://github.com/bitterteasweetorange/nvim/blob/main/lua/plugins/cmp.lua
      -- Set configuration for specific filetype.
      require('cmp_git').setup()

      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        }),
      })

      cmp.setup.filetype('NeogitCommitMessage', {
        sources = cmp.config.sources({
          { name = 'git' }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = 'buffer' },
        }),
      })

      -- cmp.setup {
      --   sources = {
      --     { name = 'nvim_lsp' },
      --     -- { name = "cody" },
      --     { name = 'path' },
      --     { name = 'buffer' },
      --   },
      --   mapping = {
      --     ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
      --     ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
      --     ['<C-y>'] = cmp.mapping(
      --       cmp.mapping.confirm {
      --         behavior = cmp.ConfirmBehavior.Insert,
      --         select = true,
      --       },
      --       { 'i', 'c' }
      --     ),
      --   },
      -- }

      cmp.setup {
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources(cmp_default_sources),
        -- enabled = function()
        --   return vim.api.nvim_buf_get_option(0, 'buftype') ~= 'prompt' or require('cmp_dap').is_dap_buffer()
        -- end,
        mapping = cmp.mapping.preset.insert {
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-n>'] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-p>'] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping {
            i = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = false },
            c = function(fallback)
              if cmp.get_selected_entry() then
                cmp.confirm { select = true }
              else
                fallback()
              end
            end,
          },
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            elseif has_words_before() then
              cmp.complete()
            else
              fallback()
            end
          end, { 'i', 's' }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback()
            end
          end, { 'i', 's' }),
        },
        experimental = {
          ghost_text = {
            hl_group = 'CmpGhostText',
          },
        },
        formatting = {
          fields = { 'kind', 'menu', 'abbr' },
          format = function(entry, vim_item)
            if vim.tbl_contains({ 'fuzzy_path', 'async_path', 'path' }, entry.source.name) then
              local icon, hl_group = require('nvim-web-devicons').get_icon(entry:get_completion_item().label)
              if icon then
                vim_item.kind = icon:gsub('^%s+', ''):gsub('%s+$', '') .. ' File'
                vim_item.kind_hl_group = hl_group
              end
            end

            local present, lspkind = pcall(require, 'lspkind')
            -- local icons = require('lazyvim.config').icons
            local icons = require 'config.icons'

            if not present then
              return vim_item
            else
              local result = lspkind.cmp_format {
                mode = 'symbol_text',
                menu = {
                  fuzzy_buffer = '「BUF」',
                  luasnip = '「SNIP」',
                  nvim_lsp = '「LSP」',
                  otter = '「LSP」',
                  calc = '「CALC」',
                  async_path = '「PATH」',
                  fuzzy_path = '「PATH」',
                  tmux = '「TMUX」',
                  -- dap = '「DAP」',
                  dynamic = '「CUS」',
                  browser = '「WWW」',
                  -- codeium = '「AI」',

                  -- fish = '「FISH」',
                  -- ['vim-dadbod-completion'] = '「DB」',
                },
                symbol_map = {
                  File = icons.File,
                  Module = icons.Module,
                  Class = icons.Class,
                  Method = icons.Method,
                  Property = icons.Property,
                  Field = icons.Field,
                  Constructor = icons.Constructor,
                  Enum = icons.Enum,
                  Interface = icons.Interface,
                  Function = icons.Function,
                  Variable = icons.Variable,
                  Constant = icons.Constant,
                  Text = icons.Text,
                  Keyword = icons.Keyword,
                  EnumMember = icons.EnumMember,
                  Struct = icons.Struct,
                  Event = icons.Event,
                  Operator = icons.Operator,
                  TypeParameter = icons.TypeParameter,

                  Snippet = icons.Snippet,
                  Unit = icons.Unit,
                  Value = icons.Value,
                  Color = icons.Color,
                  Reference = icons.Reference,
                  Folder = icons.folder,
                  Codeium = icons.Codeium,
                },
              }(entry, vim_item)

              local strings = vim.split(result.kind, '%s', { trimempty = true })
              result.kind = ' ' .. (strings[1] or '') .. ' '

              return result
            end
          end,
        },
        window = {
          completion = {
            winhighlight = 'Normal:Pmenu,FloatBorder:Pmenu,Search:None',
            col_offset = -3,
            side_padding = 0,
            border = 'rounded',
            scrollbar = '║',
          },
          documentation = {
            border = 'rounded',
          },
        },
        sorting = {
          priority_weight = 2,
          comparators = {
            compare.offset,
            compare.exact,
            compare.score,
            compare.recently_used,
            compare.kind,
            compare.sort_text,
            compare.length,
            compare.order,
            require 'cmp_fuzzy_buffer.compare',
            require 'cmp_fuzzy_path.compare',
          },
        },
      }
    end,
    --
  },

  -- support auto-detecting and selecting yaml schemas.
  -- use ":Telescope yaml_schema" to change current schema.
  {
    'someone-stole-my-name/yaml-companion.nvim',
    ft = { 'yaml', 'yaml.ansible' },
    dependencies = {
      { 'neovim/nvim-lspconfig' },
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope.nvim' },
    },
    config = function()
      local cfg = require('yaml-companion').setup {
        builtin_matchers = {
          -- Detects Kubernetes files based on content
          kubernetes = { enabled = true },
          cloud_init = { enabled = true },
        },

        -- Additional schemas available in Telescope picker
        schemas = {
          --{
          name = 'Kubernetes 1.22.4',
          uri = 'https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json',
          --},
        },

        -- Pass any additional options that will be merged in the final LSP config
        lspconfig = {
          flags = {
            debounce_text_changes = 150,
          },
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              validate = true,
              format = { enable = true },
              hover = true,
              schemaStore = {
                enable = true,
                url = 'https://www.schemastore.org/api/json/catalog.json',
              },
              schemaDownload = { enable = true },
              schemas = {},
              trace = { server = 'debug' },
            },
          },
        },
      }
      require('lspconfig')['yamlls'].setup(cfg)
      require('telescope').load_extension 'yaml_schema'
    end,
  },
}
