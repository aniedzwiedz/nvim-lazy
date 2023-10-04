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
  -- add cmp-emoji
  {
    "hrsh7th/nvim-cmp",
    dependencies = { "hrsh7th/cmp-emoji", "hrsh7th/cmp-buffer", "hrsh7th/cmp-path" },
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      local cmp = require("cmp")
      opts.sources = cmp.config.sources(vim.list_extend(opts.sources, { { name = "emoji" } }))
    end,
  },

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      { "folke/neoconf.nvim", cmd = "Neoconf", config = false, dependencies = { "nvim-lspconfig" } },
      { "folke/neodev.nvim", opts = {} },
      "mason.nvim",
      "williamboman/mason-lspconfig.nvim",
      {
        "hrsh7th/cmp-nvim-lsp",
        cond = function()
          return require("lazyvim.util").has("nvim-cmp")
        end,
      },
    },
    ---@class PluginLspOpts
    opts = {
      -- options for vim.diagnostic.config()
      diagnostics = {
        underline = true,
        update_in_insert = false,
        virtual_text = {
          spacing = 5,
          source = "if_many",
          prefix = " ● ",
          -- this will set set the prefix to a function that returns the diagnostics icon based on the severity
          -- this only works on a recent 0.10.0 build. Will be set to "●" when not supported
          -- prefix = "icons",
        },
        severity_sort = true,
      },
      -- Enable this to enable the builtin LSP inlay hints on Neovim >= 0.10.0
      -- Be aware that you also will need to properly configure your LSP server to
      -- provide the inlay hints.
      inlay_hints = {
        enabled = false,
      },
      -- add any global capabilities here
      capabilities = {},
      -- Automatically format on save
      autoformat = false,
      -- Enable this to show formatters used in a notification
      -- Useful for debugging formatter issues
      format_notify = true,
      -- options for vim.lsp.buf.format
      -- `bufnr` and `filter` is handled by the LazyVim formatter,
      -- but can be also overridden when specified
      format = {
        formatting_options = nil,
        timeout_ms = nil,
      },
      -- LSP Server Settings
      ---@type lspconfig.options
      servers = {
        jsonls = {},
        eslint = {},
        terraformls = {},
        dockerls = {},
        docker_compose_language_service = {},
        lua_ls = {
          -- mason = false, -- set to false if you don't want this server to be installed with mason
          -- Use this to add any additional keymaps
          -- for specific lsp servers
          ---@type LazyKeys[]
          -- keys = {},
          settings = {
            Lua = {
              workspace = {
                checkThirdParty = false,
              },
              completion = {
                callSnippet = "Replace",
              },
            },
          },
        },

        yamlls = {
          -- Have to add this for yamlls to understand that we support line folding
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
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
              validate = true,
              schemaStore = {
                -- Must disable built-in schemaStore support to use
                -- schemas from SchemaStore.nvim plugin
                enable = false,
                -- Schemas to support ICHA
                schemas = {
                  ["schemas/conf/ansible.json"] = "conf/ansible.yaml",
                  ["schemas/conf/jenkins/endpoints.json"] = "conf/jenkins/endpoints.yaml",
                  ["schemas/conf/jenkins/settings.json"] = "conf/jenkins/settings.yaml",
                  ["schemas/conf/jenkins/acgs/components.json"] = "conf/jenkins/acgs/components.yaml",
                  ["schemas/conf/jenkins/acgs/config.json"] = "conf/jenkins/acgs/config.yaml",
                  ["schemas/conf/jenkins/acgs/streams.json"] = "conf/jenkins/acgs/streams.yaml",
                  ["schemas/conf/jenkins/aops/components.json"] = "conf/jenkins/aops/components.yaml",
                  ["schemas/conf/jenkins/aops/config.json"] = "conf/jenkins/aops/config.yaml",
                  ["schemas/conf/jenkins/aops/streams.json"] = "conf/jenkins/aops/streams.yaml",
                  ["schemas/conf/jenkins/arbus/components.json"] = "conf/jenkins/arbus/components.yaml",
                  ["schemas/conf/jenkins/arbus/config.json"] = "conf/jenkins/arbus/config.yaml",
                  ["schemas/conf/jenkins/boa/components.json"] = "conf/jenkins/boa/components.yaml",
                  ["schemas/conf/jenkins/boa/config.json"] = "conf/jenkins/boa/config.yaml",
                  ["schemas/conf/jenkins/tpm/components.json"] = "conf/jenkins/tpm/components.yaml",
                  ["schemas/conf/jenkins/tpm/config.json"] = "conf/jenkins/tpm/config.yaml",
                  ["schemas/conf/jenkins/config.json"] = "conf/jenkins/apw/config.yaml",
                  ["schemas/conf/jenkins/components.json"] = "conf/jenkins/apw/components.yaml",
                  ["schemas/conf/pullrequests.json"] = "conf/jenkins/pullrequests.yaml",
                  ["schemas/data/env/env_file.json"] = "data/env/*.yaml",
                  ["schemas/profiles.json"] = "profiles/**/*.yaml",
                  ["schemas/products.json"] = "products/**/*.yaml",
                },

                -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
                url = "",
              },
              schemas = {
                ["schemas/conf/ansible.json"] = "conf/ansible.yaml",
                ["schemas/conf/jenkins/endpoints.json"] = "conf/jenkins/endpoints.yaml",
                ["schemas/conf/jenkins/settings.json"] = "conf/jenkins/settings.yaml",
                ["schemas/conf/jenkins/acgs/components.json"] = "conf/jenkins/acgs/components.yaml",
                ["schemas/conf/jenkins/acgs/config.json"] = "conf/jenkins/acgs/config.yaml",
                ["schemas/conf/jenkins/acgs/streams.json"] = "conf/jenkins/acgs/streams.yaml",
                ["schemas/conf/jenkins/aops/components.json"] = "conf/jenkins/aops/components.yaml",
                ["schemas/conf/jenkins/aops/config.json"] = "conf/jenkins/aops/config.yaml",
                ["schemas/conf/jenkins/aops/streams.json"] = "conf/jenkins/aops/streams.yaml",
                ["schemas/conf/jenkins/arbus/components.json"] = "conf/jenkins/arbus/components.yaml",
                ["schemas/conf/jenkins/arbus/config.json"] = "conf/jenkins/arbus/config.yaml",
                ["schemas/conf/jenkins/boa/components.json"] = "conf/jenkins/boa/components.yaml",
                ["schemas/conf/jenkins/boa/config.json"] = "conf/jenkins/boa/config.yaml",
                ["schemas/conf/jenkins/tpm/components.json"] = "conf/jenkins/tpm/components.yaml",
                ["schemas/conf/jenkins/tpm/config.json"] = "conf/jenkins/tpm/config.yaml",
                ["schemas/conf/jenkins/config.json"] = "conf/jenkins/apw/config.yaml",
                ["schemas/conf/jenkins/components.json"] = "conf/jenkins/apw/components.yaml",
                ["schemas/conf/pullrequests.json"] = "conf/jenkins/pullrequests.yaml",
                ["schemas/data/env/env_file.json"] = "data/env/*.yaml",
                ["schemas/profiles.json"] = "profiles/**/*.yaml",
                ["schemas/products.json"] = "products/**/*.yaml",
              },
            },
          },
        },
        ansiblels = {
          settings = {
            ansible = {
              -- ansible-lint runs from null-ls to ignore local .ansible-lint file.
              validation = {
                enabled = true,
                lint = {
                  enabled = false,
                },
              },
            },
          },
        },
      },
      -- you can do any additional lsp server setup here
      -- return true if you don't want this server to be setup with lspconfig
      ---@type table<string, fun(server:string, opts:_.lspconfig.options):boolean?>
      setup = {
        -- example to setup with typescript.nvim
        -- tsserver = function(_, opts)
        --   require("typescript").setup({ server = opts })
        --   return true
        -- end,
        -- Specify * to use this function as a fallback for any server
        -- ["*"] = function(server, opts) end,
        eslint = function() -- https://www.lazyvim.org/configuration/recipes
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
    ---@param opts PluginLspOpts
    config = function(_, opts)
      local Util = require("lazyvim.util")

      if Util.has("neoconf.nvim") then
        local plugin = require("lazy.core.config").spec.plugins["neoconf.nvim"]
        require("neoconf").setup(require("lazy.core.plugin").values(plugin, "opts", false))
      end
      -- setup autoformat
      require("lazyvim.plugins.lsp.format").setup(opts)
      -- setup formatting and keymaps
      Util.on_attach(function(client, buffer)
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
      end)

      local register_capability = vim.lsp.handlers["client/registerCapability"]

      vim.lsp.handlers["client/registerCapability"] = function(err, res, ctx)
        local ret = register_capability(err, res, ctx)
        local client_id = ctx.client_id
        ---@type lsp.Client
        local client = vim.lsp.get_client_by_id(client_id)
        local buffer = vim.api.nvim_get_current_buf()
        require("lazyvim.plugins.lsp.keymaps").on_attach(client, buffer)
        return ret
      end

      -- diagnostics
      for name, icon in pairs(require("lazyvim.config").icons.diagnostics) do
        name = "DiagnosticSign" .. name
        vim.fn.sign_define(name, { text = icon, texthl = name, numhl = "" })
      end

      local inlay_hint = vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint

      if opts.inlay_hints.enabled and inlay_hint then
        Util.on_attach(function(client, buffer)
          if client.supports_method("textDocument/inlayHint") then
            inlay_hint(buffer, true)
          end
        end)
      end

      if type(opts.diagnostics.virtual_text) == "table" and opts.diagnostics.virtual_text.prefix == "icons" then
        opts.diagnostics.virtual_text.prefix = vim.fn.has("nvim-0.10.0") == 0 and "●"
          or function(diagnostic)
            local icons = require("lazyvim.config").icons.diagnostics
            for d, icon in pairs(icons) do
              if diagnostic.severity == vim.diagnostic.severity[d:upper()] then
                return icon
              end
            end
          end
      end

      vim.diagnostic.config(vim.deepcopy(opts.diagnostics))

      local servers = opts.servers
      local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
      local capabilities = vim.tbl_deep_extend(
        "force",
        {},
        vim.lsp.protocol.make_client_capabilities(),
        has_cmp and cmp_nvim_lsp.default_capabilities() or {},
        opts.capabilities or {}
      )

      local function setup(server)
        local server_opts = vim.tbl_deep_extend("force", {
          capabilities = vim.deepcopy(capabilities),
        }, servers[server] or {})

        if opts.setup[server] then
          if opts.setup[server](server, server_opts) then
            return
          end
        elseif opts.setup["*"] then
          if opts.setup["*"](server, server_opts) then
            return
          end
        end
        require("lspconfig")[server].setup(server_opts)
      end

      -- get all the servers that are available through mason-lspconfig
      local have_mason, mlsp = pcall(require, "mason-lspconfig")
      local all_mslp_servers = {}
      if have_mason then
        all_mslp_servers = vim.tbl_keys(require("mason-lspconfig.mappings.server").lspconfig_to_package)
      end

      local ensure_installed = {} ---@type string[]
      for server, server_opts in pairs(servers) do
        if server_opts then
          server_opts = server_opts == true and {} or server_opts
          -- run manual setup if mason=false or if this is a server that cannot be installed with mason-lspconfig
          if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
            setup(server)
          else
            ensure_installed[#ensure_installed + 1] = server
          end
        end
      end

      if have_mason then
        mlsp.setup({ ensure_installed = ensure_installed, handlers = { setup } })
      end

      if Util.lsp_get_config("denols") and Util.lsp_get_config("tsserver") then
        local is_deno = require("lspconfig.util").root_pattern("deno.json", "deno.jsonc")
        Util.lsp_disable("tsserver", is_deno)
        Util.lsp_disable("denols", function(root_dir)
          return not is_deno(root_dir)
        end)
      end
    end,
  },
}
