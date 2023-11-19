return {
  "hrsh7th/nvim-cmp",
  config = function()
    vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
    vim.api.nvim_set_hl(0, "CmpItemKindTabnine", { fg = "#CA42F0" })
    vim.api.nvim_set_hl(0, "CmpItemKindCrate", { fg = "#F64D00" })
    vim.api.nvim_set_hl(0, "CmpItemKindEmoji", { fg = "#FDE030" })

    local cmp = require("cmp")
    local luasnip = require("luasnip")
    local lspkind = require("lspkind")
    require("luasnip/loaders/from_vscode").lazy_load()
    require("luasnip").filetype_extend("typescriptreact", { "html" })

    local check_backspace = function()
      local col = vim.fn.col(".") - 1
      return col == 0 or vim.fn.getline("."):sub(col, col):match("%s")
    end

    require("luasnip/loaders/from_vscode").lazy_load()

    vim.opt.completeopt = "menu,menuone,noselect"
    local icons = require("config.icons")

    cmp.setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body) -- For `luasnip` users.
        end,
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
        { name = "codeium" },
        { name = "nvim_lsp" }, -- lsp
        { name = "luasnip" }, -- snippets
        { name = "path" }, -- file system paths
        { name = "buffer" }, -- text within current buffer
      }),
      -- configure lspkind for vs-code like icons
      -- formatting = {
      --   format = lspkind.cmp_format({
      --     maxwidth = 50,
      --     ellipsis_char = "...",
      --   }),
      -- },

      formatting = {
        format = require("lspkind").cmp_format({
          mode = "symbol",
          maxwidth = 50,
          ellipsis_char = "...",
          symbol_map = { Codeium = "" },
        }),
      },
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
  end,
  dependencies = {
    {
      "hrsh7th/cmp-nvim-lsp",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-emoji",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-buffer",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-path",
      event = "InsertEnter",
    },
    {
      "hrsh7th/cmp-cmdline",
      event = "InsertEnter",
    },
    {
      "saadparwaiz1/cmp_luasnip",
      event = "InsertEnter",
    },
    {
      "L3MON4D3/LuaSnip",
      event = "InsertEnter",
      dependencies = {
        "rafamadriz/friendly-snippets",
      },
    },
    {
      "hrsh7th/cmp-nvim-lua",
      event = "InsertEnter",
    },
    { "onsails/lspkind.nvim", event = "InsertEnter" },
    {
      "Exafunction/codeium.nvim",
      cmd = "Codeium",
      build = ":Codeium Auth",
      opts = {},
    },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, 1, {
        name = "codeium",
        group_index = 1,
        priority = 100,
      })
    end,
  },

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
}
