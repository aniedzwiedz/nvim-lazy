return { -- Autocompletion
  'hrsh7th/nvim-cmp',
  event = 'InsertEnter',
  dependencies = {
    -- Snippet Engine & its associated nvim-cmp source
    {
      'L3MON4D3/LuaSnip',
      build = (function()
        -- Build Step is needed for regex support in snippets.
        -- This step is not supported in many windows environments.
        -- Remove the below condition to re-enable on windows.
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp'
      end)(),
      dependencies = {
        -- `friendly-snippets` contains a variety of premade snippets.
        --    See the README about individual language/framework/plugin snippets:
        --    https://github.com/rafamadriz/friendly-snippets
        { 'benfowler/telescope-luasnip.nvim' },
        {
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
    },
    'saadparwaiz1/cmp_luasnip',

    -- Adds other completion capabilities.
    --  nvim-cmp does not ship with all sources by default. They are split
    --  into multiple repos for maintenance purposes.
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-emoji',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'hrsh7th/cmp-cmdline',
    'hrsh7th/cmp-nvim-lua',
    'onsails/lspkind.nvim', -- Adds vscode-like pictograms
    'petertriho/cmp-git',
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
  },
  config = function(_, opts)
    table.insert(opts.sources, { name = 'git' })

    if opts then
      require('luasnip').config.setup(opts)
    end
    vim.tbl_map(function(type)
      require('luasnip.loaders.from_' .. type).lazy_load()
    end, { 'vscode', 'snipmate', 'lua' })
    -- friendly-snippets - enable standardized comments snippets
    require('luasnip').filetype_extend('typescript', { 'tsdoc' })
    require('luasnip').filetype_extend('javascript', { 'jsdoc' })
    require('luasnip').filetype_extend('lua', { 'luadoc' })
    require('luasnip').filetype_extend('python', { 'pydoc' })
    require('luasnip').filetype_extend('rust', { 'rustdoc' })
    require('luasnip').filetype_extend('cs', { 'csharpdoc' })
    require('luasnip').filetype_extend('java', { 'javadoc' })
    require('luasnip').filetype_extend('c', { 'cdoc' })
    require('luasnip').filetype_extend('cpp', { 'cppdoc' })
    require('luasnip').filetype_extend('php', { 'phpdoc' })
    require('luasnip').filetype_extend('kotlin', { 'kdoc' })
    require('luasnip').filetype_extend('ruby', { 'rdoc' })
    require('luasnip').filetype_extend('sh', { 'shelldoc' })

    require('luasnip.loaders.from_vscode').lazy_load { paths = { './snippets/' } }

    -- See `:help cmp`
    local cmp = require 'cmp'
    local lspkind = require 'lspkind'
    local luasnip = require 'luasnip'
    local compare = require 'cmp.config.compare'
    luasnip.config.setup {}

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

    cmp.setup {
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = { completeopt = 'menu,menuone,noinsert' },

      -- For an understanding of why these mappings were
      -- chosen, you will need to read `:help ins-completion`
      --
      -- No, but seriously. Please read `:help ins-completion`, it is really good!
      --       mapping = cmp.mapping.preset.insert {
      -- Select the [n]ext item
      --          ['<C-n>'] = cmp.mapping.select_next_item(),
      -- Select the [p]revious item
      --          ['<C-p>'] = cmp.mapping.select_prev_item(),

      -- Accept ([y]es) the completion.
      --  This will auto-import if your LSP supports it.
      --  This will expand snippets if the LSP sent a snippet.
      --         ['<C-y>'] = cmp.mapping.confirm { select = true },

      -- Manually trigger a completion from nvim-cmp.
      --  Generally you don't need this, because nvim-cmp will display
      --  completions whenever it has completion options available.
      --        ['<C-Space>'] = cmp.mapping.complete {},

      -- Think of <c-l> as moving to the right of your snippet expansion.
      --  So if you have a snippet that's like:
      --  function $name($args)
      --    $body
      --  end
      --
      -- <c-l> will move you to the right of each of the expansion locations.
      -- <c-h> is similar, except moving you backwards.
      --          ['<C-l>'] = cmp.mapping(function()
      --            if luasnip.expand_or_locally_jumpable() then
      --              luasnip.expand_or_jump()
      --          end
      --         end, { 'i', 's' }),
      --        ['<C-h>'] = cmp.mapping(function()
      --          if luasnip.locally_jumpable(-1) then
      --             luasnip.jump(-1)
      --          end
      --        end, { 'i', 's' }),
      --     },

      mapping = cmp.mapping.preset.insert {
        ['<C-k>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-j>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<Down>'] = cmp.mapping(cmp.mapping.select_next_item(), { 'i', 'c' }),
        ['<Up>'] = cmp.mapping(cmp.mapping.select_prev_item(), { 'i', 'c' }),
        ['<C-b>'] = cmp.mapping(cmp.mapping.scroll_docs(-1), { 'i', 'c' }),
        ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(1), { 'i', 'c' }),
        ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
        ['<C-e>'] = cmp.mapping {
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        },
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ['<CR>'] = cmp.mapping.confirm { select = true },
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expandable() then
            luasnip.expand()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          elseif check_backspace() then
            fallback()
          else
            fallback()
          end
        end, {
          'i',
          's',
        }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          'i',
          's',
        }),
      },
      sources = {
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'buffer' },
        { name = 'path' },
      },
    }
  end,
}
