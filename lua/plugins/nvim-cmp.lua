return {
  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      {
        "Saecki/crates.nvim",
        event = { "BufRead Cargo.toml" },
        opts = {
          -- src = {
          --   cmp = { enabled = true },
          -- },
        },
      },
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-emoji",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      "hrsh7th/cmp-nvim-lua",
      "onsails/lspkind.nvim", -- Adds vscode-like pictograms
      -- "rafamadriz/friendly-snippets",
      "petertriho/cmp-git",
      { "L3MON4D3/LuaSnip", build = "make install_jsregexp" },
      "saadparwaiz1/cmp_luasnip",
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
      local cmp = require "cmp"
      local lspkind = require "lspkind"
      lspkind.init {}

      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(":", {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          { name = "path" },
        }, {
          { name = "cmdline" },
        }),
      })

      -- NOTE: https://github.com/bitterteasweetorange/nvim/blob/main/lua/plugins/cmp.lua
      -- Set configuration for specific filetype.
      require("cmp_git").setup()

      cmp.setup.filetype("gitcommit", {
        sources = cmp.config.sources({
          { name = "git" }, -- You can specify the `git` source if [you were installed it](https://github.com/petertriho/cmp-git).
        }, {
          { name = "buffer" },
        }),
      })

      cmp.setup.filetype("NeogitCommitMessage", {
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

      cmp.setup {
        sources = {
          { name = "nvim_lsp" },
          -- { name = "cody" },
          { name = "path" },
          { name = "buffer" },
        },
        mapping = {
          ["<C-n>"] = cmp.mapping.select_next_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-p>"] = cmp.mapping.select_prev_item { behavior = cmp.SelectBehavior.Insert },
          ["<C-y>"] = cmp.mapping(
            cmp.mapping.confirm {
              behavior = cmp.ConfirmBehavior.Insert,
              select = true,
            },
            { "i", "c" }
          ),
        },
      }
    end,
    --
  },

  -- support auto-detecting and selecting yaml schemas.
  -- use ":Telescope yaml_schema" to change current schema.
  {
    "someone-stole-my-name/yaml-companion.nvim",
    ft = { "yaml", "yaml.ansible" },
    dependencies = {
      { "neovim/nvim-lspconfig" },
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim" },
    },
    config = function()
      local cfg = require("yaml-companion").setup {
        builtin_matchers = {
          -- Detects Kubernetes files based on content
          kubernetes = { enabled = true },
          cloud_init = { enabled = true },
        },

        -- Additional schemas available in Telescope picker
        schemas = {
          --{
          name = "Kubernetes 1.22.4",
          uri = "https://raw.githubusercontent.com/yannh/kubernetes-json-schema/master/v1.22.4-standalone-strict/all.json",
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
                url = "https://www.schemastore.org/api/json/catalog.json",
              },
              schemaDownload = { enable = true },
              schemas = {},
              trace = { server = "debug" },
            },
          },
        },
      }
      require("lspconfig")["yamlls"].setup(cfg)
      require("telescope").load_extension "yaml_schema"
    end,
  },
}
