return {
  "neovim/nvim-lspconfig",
  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    keys[#keys + 1] = { "K", "<cmd>Lspsaga hover_doc<cr>" }
    -- disable a keymap
    -- keys[#keys + 1] = { "K", false }
    -- add a keymap
    -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
  end,

  opts = {
    diagnostics = {
      underline = true,
      update_in_insert = false,
      virtual_text = {
        spacing = 4,
        source = "if_many",
        prefix = "●",
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
    -- options for vim.lsp.buf.format
    -- `bufnr` and `filter` is handled by the LazyVim formatter,
    -- but can be also overridden when specified
    format = {
      formatting_options = nil,
      timeout_ms = nil,
    },

    servers = {
      lua_ls = {
        workspace = {
          checkThirdParty = false,
          library = vim.api.nvim_get_runtime_file("", true), -- Make the server aware of Neovim runtime files
        },
        completion = {
          callSnippet = "Replace",
        },
        telemetry = {
          enable = false,
        },
        diagnostics = {
          -- Get the language server to recognize the `vim` global
          globals = { "vim" },
        },
      },
      ---@type lspconfig.options.tsserver
      tsserver = {
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
          },
          {
            "<leader>cR",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.removeUnused.ts" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Remove Unused Imports",
          },
        },
        settings = {
          typescript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          javascript = {
            format = {
              indentSize = vim.o.shiftwidth,
              convertTabsToSpaces = vim.o.expandtab,
              tabSize = vim.o.tabstop,
            },
          },
          completions = {
            completeFunctionCalls = true,
          },
        },
      },

      cssls = {},
      marksman = {},
      dockerls = {},
      eslint = {},
      docker_compose_language_service = {},
      solargraph = {},
      jdtls = {},
      terraformls = {},
      puppet = {

        cmd = {
          "puppet-languageserver",
          "--stdio",
          "--puppet-settings=--modulepath,/code/a32-tools:/code/puppet:/code/puppet-forge",
        },
      },
      -- json = {
      --   schemas = require("schemastore").json.schemas({
      --     select = {
      --       ".eslintrc",
      --       "package.json",
      --     },
      --   }),
      --   validate = { enable = true },
      -- },
      jsonls = {
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            schemas = require("schemastore").json.schemas(),
            validate = { enable = true },
          },
        },
      },

      ansiblels = {
        settings = {
          ansible = {
            useFullyQualifiedCollectionNames = false,
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
      rust_analyzer = {
        keys = {
          { "K", "<cmd>RustHoverActions<cr>", desc = "Hover Actions (Rust)" },
          { "<leader>cR", "<cmd>RustCodeAction<cr>", desc = "Code Action (Rust)" },
          { "<leader>dr", "<cmd>RustDebuggables<cr>", desc = "Run Debuggables (Rust)" },
        },
        settings = {
          ["rust-analyzer"] = {
            cargo = {
              allFeatures = true,
              loadOutDirsFromCheck = true,
              runBuildScripts = true,
            },
            -- Add clippy lints for Rust.
            checkOnSave = {
              allFeatures = true,
              command = "clippy",
              extraArgs = { "--no-deps" },
              -- extraArgs = { "--", "-Aclippy::needless_return" },
            },
            procMacro = {
              enable = true,
              ignored = {
                ["async-trait"] = { "async_trait" },
                ["napi-derive"] = { "napi" },
                ["async-recursion"] = { "async_recursion" },
              },
            },
          },
        },
      },
      taplo = {
        keys = {
          {
            "K",
            function()
              if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
                require("crates").show_popup()
              else
                vim.lsp.buf.hover()
              end
            end,
            desc = "Show Crate Documentation",
          },
        },
      },
      pyright = {},
      ruff_lsp = {
        keys = {
          {
            "<leader>co",
            function()
              vim.lsp.buf.code_action({
                apply = true,
                context = {
                  only = { "source.organizeImports" },
                  diagnostics = {},
                },
              })
            end,
            desc = "Organize Imports",
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
        dependencies = {
          "b0o/SchemaStore.nvim",
          "folke/neodev.nvim",
        },
        on_new_config = function(new_config)
          -- new_config.settings.yaml.schemas = new_config.settings.yaml.schemas or {}
          -- vim.list_extend(new_config.settings.yaml.schemas, require("schemastore").yaml.schemas())
          new_config.settings.yaml.schemas =
            vim.tbl_deep_extend("force", new_config.settings.yaml.schemas or {}, require("schemastore").yaml.schemas())
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
              -- schemas = {
              --   ["schemas/conf/ansible.json"] = "conf/ansible.yaml",
              --   ["schemas/conf/jenkins/endpoints.json"] = "conf/jenkins/endpoints.yaml",
              --   ["schemas/conf/jenkins/settings.json"] = "conf/jenkins/settings.yaml",
              --   ["schemas/conf/jenkins/acgs/components.json"] = "conf/jenkins/acgs/components.yaml",
              --   ["schemas/conf/jenkins/acgs/config.json"] = "conf/jenkins/acgs/config.yaml",
              --   ["schemas/conf/jenkins/acgs/streams.json"] = "conf/jenkins/acgs/streams.yaml",
              --   ["schemas/conf/jenkins/aops/components.json"] = "conf/jenkins/aops/components.yaml",
              --   ["schemas/conf/jenkins/aops/config.json"] = "conf/jenkins/aops/config.yaml",
              --   ["schemas/conf/jenkins/aops/streams.json"] = "conf/jenkins/aops/streams.yaml",
              --   ["schemas/conf/jenkins/arbus/components.json"] = "conf/jenkins/arbus/components.yaml",
              --   ["schemas/conf/jenkins/arbus/config.json"] = "conf/jenkins/arbus/config.yaml",
              --   ["schemas/conf/jenkins/boa/components.json"] = "conf/jenkins/boa/components.yaml",
              --   ["schemas/conf/jenkins/boa/config.json"] = "conf/jenkins/boa/config.yaml",
              --   ["schemas/conf/jenkins/tpm/components.json"] = "conf/jenkins/tpm/components.yaml",
              --   ["schemas/conf/jenkins/tpm/config.json"] = "conf/jenkins/tpm/config.yaml",
              --   ["schemas/conf/jenkins/config.json"] = "conf/jenkins/apw/config.yaml",
              --   ["schemas/conf/jenkins/components.json"] = "conf/jenkins/apw/components.yaml",
              --   ["schemas/conf/pullrequests.json"] = "conf/jenkins/pullrequests.yaml",
              --   ["schemas/data/env/env_file.json"] = "data/env/*.yaml",
              --   ["schemas/profiles.json"] = "profiles/**/*.yaml",
              --   ["schemas/products.json"] = "products/**/*.yaml",
              -- },
              --
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
              ["schemas/conf/jenkins/arn/config.json"] = "conf/jenkins/arn/config.yaml",
              ["schemas/conf/jenkins/arn/streams.json"] = "conf/jenkins/arn/streams.yaml",
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
    },
    setup = {
      rust_analyzer = function(_, opts)
        local rust_tools_opts = require("lazyvim.util").opts("rust-tools.nvim")
        require("rust-tools").setup(vim.tbl_deep_extend("force", rust_tools_opts or {}, { server = opts }))
        return true
      end,

      clangd = function(_, opts)
        opts.capabilities.offsetEncoding = { "utf-16" }
      end,

      ruff_lsp = function()
        require("lazyvim.util").lsp.on_attach(function(client, _)
          if client.name == "ruff_lsp" then
            -- Disable hover in favor of Pyright
            client.server_capabilities.hoverProvider = false
          end
        end)
      end,

      jdtls = function()
        return true -- avoid duplicate servers https://www.lazyvim.org/extras/lang/java
      end,

      yamlls = function()
        -- Neovim < 0.10 does not have dynamic registration for formatting
        if vim.fn.has("nvim-0.10") == 0 then
          require("lazyvim.util").lsp.on_attach(function(client, _)
            if client.name == "yamlls" then
              client.server_capabilities.documentFormattingProvider = true
            end
          end)
        end
      end,

      eslint = function()
        require("lazyvim.util").lsp.on_attach(function(client)
          if client.name == "eslint" then
            client.server_capabilities.documentFormattingProvider = true
          elseif client.name == "tsserver" then
            client.server_capabilities.documentFormattingProvider = false
          end
        end)
      end,
    },
  },
}
