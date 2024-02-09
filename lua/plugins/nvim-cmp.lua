return {
  "hrsh7th/nvim-cmp",
  event = "InsertEnter",
  dependencies = {
    {
      "Saecki/crates.nvim",
      event = { "BufRead Cargo.toml" },
      opts = {
        src = {
          cmp = { enabled = true },
        },
      },
    },
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-emoji",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
    "saadparwaiz1/cmp_luasnip",
    "L3MON4D3/LuaSnip",
    "hrsh7th/cmp-nvim-lua",
    "onsails/lspkind.nvim",
    "rafamadriz/friendly-snippets",
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      build = ":Codeium Auth",
      opts = {},
    },
  },
  config = function()
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
    vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
    vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    -- require("luasnip/loaders/from_vscode").lazy_load()
    require("luasnip.loaders.from_vscode").load({ paths = { "./snippets/" } }) -- Load snippets from my-snippets folder
    require("luasnip").filetype_extend("typescriptreact", { "html" })

    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    -- local icons = require("config.icons")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
      },
      completion = {
        completeopt = "menu,menuone,preview,noselect",
      },
      -- mapping = cmp.mapping.preset.insert({
      --   ["<C-k>"] = cmp.mapping.select_prev_item(), -- previous suggestion
      --   ["<C-j>"] = cmp.mapping.select_next_item(), -- next suggestion
      --   ["<C-b>"] = cmp.mapping.scroll_docs(-4),
      --   ["<C-f>"] = cmp.mapping.scroll_docs(4),
      --   ["<C-Space>"] = cmp.mapping.complete(), -- show completion suggestions
      --   ["<C-e>"] = cmp.mapping.abort(), -- close completion window
      --   ["<CR>"] = cmp.mapping.confirm({ select = false }),
      -- }),

      mapping = cmp.mapping.preset.insert({
        ["<C-k>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-j>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Down>"] = cmp.mapping(cmp.mapping.select_next_item(), { "i", "c" }),
        ["<Up>"] = cmp.mapping(cmp.mapping.select_prev_item(), { "i", "c" }),
        ["<C-b>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
        ["<C-f>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),
        ["<C-Space>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }),
        ["<C-e>"] = cmp.mapping({
          i = cmp.mapping.abort(),
          c = cmp.mapping.close(),
        }),
        -- Accept currently selected item. If none selected, `select` first item.
        -- Set `select` to `false` to only confirm explicitly selected items.
        ["<CR>"] = cmp.mapping.confirm({ select = true }),
        ["<Tab>"] = cmp.mapping(function(fallback)
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
          "i",
          "s",
        }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, {
          "i",
          "s",
        }),
      }),

      -- sources for autocompletion
      sources = cmp.config.sources({
        { name = "codeium", keyword_length = 3, max_item_count = 10 },
        { name = "nvim_lsp", keyword_length = 3, max_item_count = 10 }, -- lsp
        { name = "luasnip", keyword_length = 3, max_item_count = 10 }, -- snippets
        -- { name = "crates" },
        -- { name = "buffer", keyword_length = 4, max_item_count = 10 }, -- text within current buffer
        {
          name = "buffer",
          priority_weight = 2,
          option = {
            keyword_length = 2,
            get_bufnrs = function()
              return vim.api.nvim_list_bufs()
            end,
          },
        },
        { name = "path", keyword_length = 4, max_item_count = 10 }, -- file system paths
      }),
      -- configure lspkind for vs-code like icons
      -- formatting = {
      --   format = lspkind.cmp_format({
      --     maxwidth = 50,
      --     ellipsis_char = "...",
      --   }),
      -- },
      -- formatting = {
      --   format = function(entry, item)
      --     item.menu = ({
      --       nvim_lsp = "[L]",
      --       vim_lsp = "[V]",
      --       buffer = "[B]",
      --     })[entry.source.name]
      --     return item
      --   end,
      --  },
      -- formatting = {
      --   format = require("lspkind").cmp_format({
      --     -- mode = "symbol",
      --     maxwidth = 100,
      --     ellipsis_char = ".....",
      --     symbol_map = { Codeium = "" },
      --   }),
      -- },
      -- formatting = {
      --   fields = { "kind", "abbr", "menu" },
      --   format = function(entry, vim_item)
      --     vim_item.kind = icons.kind[vim_item.kind]
      --     vim_item.menu = ({
      --       nvim_lsp = "",
      --       nvim_lua = "",
      --       luasnip = "",
      --       buffer = "",
      --       path = "",
      --       emoji = "",
      --     })[entry.source.name]
      --     if entry.source.name == "copilot" then
      --       vim_item.kind = icons.git.Octoface
      --       vim_item.kind_hl_group = "CmpItemKindCopilot"
      --     end
      --
      --     if entry.source.name == "cmp_tabnine" then
      --       vim_item.kind = icons.misc.Robot
      --       vim_item.kind_hl_group = "CmpItemKindTabnine"
      --     end
      --
      --     if entry.source.name == "crates" then
      --       vim_item.kind = icons.misc.Package
      --       vim_item.kind_hl_group = "CmpItemKindCrate"
      --     end
      --
      --     if entry.source.name == "lab.quick_data" then
      --       vim_item.kind = icons.misc.CircuitBoard
      --       vim_item.kind_hl_group = "CmpItemKindConstant"
      --     end
      --
      --     if entry.source.name == "emoji" then
      --       vim_item.kind = icons.misc.Smiley
      --       vim_item.kind_hl_group = "CmpItemKindEmoji"
      --     end
      --
      --     return vim_item
      --   end,
      -- },
      confirm_opts = {
        behavior = cmp.ConfirmBehavior.Replace,
        select = false,
      },
      window = {
        completion = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,CursorLine:PmenuSel,FloatBorder:FloatBorder,Search:None",
          col_offset = -3,
          side_padding = 1,
          scrollbar = false,
          scrolloff = 8,
        },
        documentation = {
          border = "rounded",
          winhighlight = "Normal:Pmenu,FloatBorder:FloatBorder,Search:None",
        },
      },
      experimental = {
        ghost_text = false,
      },
    })
    -- NOTE: https://github.com/bitterteasweetorange/nvim/blob/main/lua/plugins/cmp.lua
    -- Set configuration for specific filetype.
    cmp.setup.filetype("gitcommit", {
      sources = cmp.config.sources({
        { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
      }, {
        { name = "buffer" },
      }),
    })

    -- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "path" },
      }, {
        { name = "cmdline" },
      }),
    })
  end,
  ---@param opts cmp.ConfigSchema
  opts = function(_, opts)
    table.insert(opts.sources, 1, {
      name = "codeium",
      group_index = 1,
      priority = 100,
    })
  end,

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

  -- opts = function(_, opts)
  --   local cmp = require("cmp")
  --   opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
  -- end,
  --
}
