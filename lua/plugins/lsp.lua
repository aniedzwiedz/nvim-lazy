return {
  -- add symbols-outline
  {
    "simrat39/symbols-outline.nvim",
    cmd = "SymbolsOutline",
    keys = { { "<leader>cs", "<cmd>SymbolsOutline<cr>", desc = "Symbols Outline" } },
    opts = {
      -- add your options that should be passed to the setup() function here
      position = "right",
    },
  },
  {
    "neovim/nvim-lspconfig", --  NOTE: https://www.lazyvim.org/configuration/recipes
    dependencies = {
      "b0o/SchemaStore.nvim",
      version = false, -- last release is way too old
    },

    opts = {
      servers = {
        eslint = {},
        yamlls = {
          -- lazy-load schemastore when needed
          on_new_config = function(new_config)
            new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
            vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = { enable = true },
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
            },
          },
        },
      },
      setup = {
        eslint = function()
          require("lazyvim.util").on_attach(function(client)
            if client.name == "eslint" then
              client.server_capabilities.documentFormattingProvider = true
            elseif client.name == "tsserver" then
              client.server_capabilities.documentFormattingProvider = false
            end
          end)
        end,
      },
    },
  },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        vim.list_extend(opts.ensure_installed, { "yaml" })
      end
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },
  {
    "lvimuser/lsp-inlayhints.nvim",
    ft = { "javascript", "javascriptreact", "json", "jsonc", "typescript", "typescriptreact", "svelte" },
    enabled = enabled_inlay_hints,
    opts = {
      debug_mode = true,
    },
    config = function(_, options)
      vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
      vim.api.nvim_create_autocmd("LspAttach", {
        group = "LspAttach_inlayhints",
        callback = function(args)
          if not (args.data and args.data.client_id) then
            return
          end

          local bufnr = args.buf
          local client = vim.lsp.get_client_by_id(args.data.client_id)
          require("lsp-inlayhints").on_attach(client, bufnr)
        end,
      })
      require("lsp-inlayhints").setup(options)
      -- define key map for toggle inlay hints: require('lsp-inlayhints').toggle()
      vim.api.nvim_set_keymap(
        "n",
        "<leader>uI",
        "<cmd>lua require('lsp-inlayhints').toggle()<CR>",
        { noremap = true, silent = true }
      )
    end,
  },

  {
    "glepnir/lspsaga.nvim",
    event = "LspAttach",
    config = true,
    dependencies = {
      { "nvim-tree/nvim-web-devicons" },
      -- Please make sure you install markdown and markdown_inline parser
      { "nvim-treesitter/nvim-treesitter" },
    },
  },
  {
    -- Dim the unused variables and functions using lsp and treesitter.
    "narutoxy/dim.lua",
    event = "BufRead",
    dependencies = { "nvim-treesitter/nvim-treesitter", "neovim/nvim-lspconfig" },
    config = true,
  },
  {
    -- Displaying references and definition infos upon functions like JB's IDEA.
    "VidocqH/lsp-lens.nvim",
    event = "BufRead",
    opts = {
      include_declaration = true, -- Reference include declaration
      sections = { -- Enable / Disable specific request
        definition = false,
        references = true,
        implementation = false,
      },
    },
    keys = {
      {
        -- LspLensToggle
        "<leader>uL",
        "<cmd>LspLensToggle<CR>",
        desc = "LSP Len Toggle",
      },
    },
  },

  -- Add Codeium status to lualine
  {
    "nvim-lualine/lualine.nvim",
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 2, {
        function()
          return vim.fn["codeium#GetStatusString"]()
        end,
      })
    end,
  },
}
