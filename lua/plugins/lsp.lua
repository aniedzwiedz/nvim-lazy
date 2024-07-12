return {
  --
  -- require("lspconfig").azure_pipelines_ls.setup {
  --   settings = {
  --     yaml = {
  --       schemas = {
  --         ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
  --           "/azure-pipeline*.y*l",
  --           "/*.azure*",
  --           "Azure-Pipelines/**/*.y*l",
  --           "Pipelines/*.y*l",
  --         },
  --       },
  --     },
  --   },
  -- },
  'neovim/nvim-lspconfig',
  dependencies = {
    {
      'b0o/SchemaStore.nvim',
      lazy = true,
      version = false, -- last release is way too old
    },
    {
      'williamboman/mason.nvim',
      opts = {
        ensure_installed = {
          'ansible-lint',
        },
      },
    },
    'williamboman/mason-lspconfig.nvim',
    { 'towolf/vim-helm', ft = 'helm' },
  },
  ---@class PluginLspOpts
  opts = {
    -- inlay_hints = {
    --   enabled = true,
    -- },
    -- Enable lsp cursor word highlighting
    document_highlight = {
      enabled = true,
    },
    servers = {
      --     ['helm_ls'] = {
      -- yamlls = {
      --   path = "yaml-language-server",
      -- }},
      helm_ls = { -- https://github.com/mrjosh/helm-ls/blob/master/examples/nvim/init.lua
        -- settings = {
        --   ['helm-ls'] = {
        --     yamlls = {
        --       path = 'yaml-language-server',
        --     },
        --   },
        -- },
      },
      ansiblels = {},
      -- NOTE:
      -- ruby_lsp will be automatically installed with mason and loaded with lspconfig
      -- https://github.com/LazyVim/LazyVim/pull/3652/
      -- disable solargraph from auto running when you open ruby files
      solargraph = {
        autostart = false,
      },
      -- ruby_lsp will be automatically installed with mason and loaded with lspconfig
      ruby_lsp = {},
      azure_pipelines_ls = {
        settings = {
          yaml = {
            schemas = {
              ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] = {
                '*/.azuredevops/**/*.y*ml',
              },
            },
          },
        },
      },
      terraformls = {
        keys = {
          { '<leader>sXt', '<cmd>Telescope terraform_doc<CR>', desc = 'Telescope terraform_doc' },
          { '<leader>sXm', '<cmd>Telescope terraform_doc modules<CR>', desc = 'Telescope terraform_doc modules' },
          {
            '<leader>sTa',
            '<cmd>Telescope terraform_doc full_name=hashicorp/aws<CR>',
            desc = 'Telescope terraform_doc hashicorp/aws',
          },
          {
            '<leader>sTg',
            '<cmd>Telescope terraform_doc full_name=hashicorp/google<CR>',
            desc = 'Telescope terraform_doc hashicorp/google',
          },
          {
            '<leader>sTk',
            '<cmd>Telescope terraform_doc full_name=hashicorp/kubernetes<CR>',
            desc = 'Telescope terraform_doc hashicorp/kubernetes',
          },
        },
        -- cmd = { 'terraform-ls' },
        -- arg = { 'server' },
        -- filetypes = { 'terraform', 'tf', 'terraform-vars' },
      },
      groovyls = {},
      marksman = {},
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
          new_config.settings.yaml.schemas =
            vim.tbl_deep_extend('force', new_config.settings.yaml.schemas or {}, require('schemastore').yaml.schemas())
        end,
        -- cmd = { "yaml-language-server", "--stdio" },
        -- filetypes = { 'yaml' },

        settings = {
          redhat = { telemetry = { enabled = false } },
          yaml = {
            validate = true,
            keyOrdering = false,
            -- disable the schema store
            format = {
              enable = true,
            },
            schemaStore = {
              -- Must disable built-in schemaStore support to use
              -- schemas from SchemaStore.nvim plugin
              enable = false,
              -- Avoid TypeError: Cannot read properties of undefined (reading 'length')
              url = '',

              -- enable = true,  -- https://www.lazyvim.org/extras/lang/yaml
              -- url = 'https://www.schemastore.org/api/json/catalog.json',
            },
            hover = true,
            schemaDownload = {
              enable = true,
            },
            trace = { server = 'info' },
            schemas = require('schemastore').yaml.schemas {
              kubernetes = { 'k8s**.yaml', 'kube*/*.yaml' },
              -- ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] = "/*.k8s.yaml",
              -- select subset from the JSON schema catalog
              ['https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json'] = '/*.k8s.yaml',
              ['https://json.schemastore.org/github-workflow.json'] = '/.github/workflows/*',
              -- ['../path/relative/to/file.yml'] = '/.github/workflows/*',
              -- ['/path/from/root/of/project'] = '/.github/workflows/*',
              -- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
              ['/conf/jenkins/arn/'] = '/schemas/conf/jenkins/arn/*',
              select = {
                'kustomization.yaml',
                'docker-compose.yml',
              },

              -- additional schemas (not in the catalog)
              extra = {
                url = 'https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json',
                name = 'Argo CD Application',
                fileMatch = 'argocd-application.yaml',
              },
            },
          },
        },
      },
      bashls = {
        filetypes = { 'sh', 'zsh' },
      },
      vimls = {
        filetypes = { 'vim' },
      },
      lua_ls = {
        single_file_support = true,
        settings = {
          Lua = {
            diagnostics = {
              globals = { 'vim', 'awesome' },
            },
            telemetry = {
              enable = false,
            },
            format = {
              enable = true,
              defaultConfig = {
                indent_style = 'space',
                indent_size = '2',
                continuation_indent_size = '2',
              },
            },
            doc = {
              privateName = { '^_' },
            },
            type = {
              castNumberToInteger = true,
            },
            hint = {
              enable = true,
              setType = false,
              paramType = true,
              paramName = 'Disable',
              semicolon = 'Disable',
              arrayIndex = 'Disable',
            },
            completion = {
              workspaceWord = true,
              callSnippet = 'Replace',
            },
          },
        },
      },
      -- lua_ls = {
      --   settings = {
      --     Lua = {
      --       diagnostics = {
      --         globals = { 'vim', 'awesome' },
      --       },
      --       telemetry = {
      --         enable = false,
      --       },
      --       format = {
      --         enable = true,
      --         defaultConfig = {
      --           indent_style = 'space',
      --           indent_size = '2',
      --         },
      --       },
      --       hint = {
      --         enable = true,
      --       },
      --       completion = {
      --         callSnippet = 'Replace',
      --       },
      --     },
      --   },
      -- },
      -- lua_ls = {
      --   settings = {
      --     Lua = {
      --       hint = {
      --         enable = true,
      --       }
      --       runtime = { version = "LuaJIT" },
      --       workspace = {
      --         checkThirdParty = false,
      --         -- Tells lua_ls where to find all the Lua files that you have loaded
      --         -- for your neovim configuration.
      --         library = {
      --           "${3rd}/luv/library",
      --           unpack(vim.api.nvim_get_runtime_file("", true)),
      --         },
      --         -- If lua_ls is really slow on your computer, you can try this instead:
      --         -- library = { vim.env.VIMRUNTIME },
      --       },
      --       completion = {
      --         callSnippet = "Replace",
      --       },
      --       -- You can toggle below to ignore Lua_LS's noisy `missing-fields` warnings
      --       -- diagnostics = { disable = { 'missing-fields' } },
      --     },
      --   },
      -- },
      jsonls = {
        -- lazy-load schemastore when needed
        on_new_config = function(new_config)
          new_config.settings.json.schemas = new_config.settings.json.schemas or {}
          vim.list_extend(new_config.settings.json.schemas, require('schemastore').json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            select = {
              '.eslintrc',
              'package.json',
              'Renovate',
              'GitHub Workflow Template Properties',
            },
            validate = { enable = true },
          },
        },
      },
      --       taplo = {
      --   keys = {
      --     {
      --       "K",
      --       function()
      --         if vim.fn.expand("%:t") == "Cargo.toml" and require("crates").popup_available() then
      --           require("crates").show_popup()
      --         else
      --           vim.lsp.buf.hover()
      --         end
      --       end,
      --       desc = "Show Crate Documentation",
      --     },
      --   },
      -- },
    },
    setup = {
      -- azure_pipelines_ls = function()
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] = {
      --           '/azure-pipeline*.y*l',
      --           '/*.azure*',
      --           'Azure-Pipelines/**/*.y*l',
      --           'Pipelines/*.y*l',
      --         },
      --       },
      --     },
      --   }
      -- end,

      yamlls = function()
        LazyVim.lsp.on_attach(function(client, buffer)
          if vim.bo[buffer].filetype == 'helm' then
            vim.schedule(function()
              vim.cmd 'LspStop ++force yamlls'
            end)
          end
        end, 'yamlls')
      end,
    },
  },

  -- setup = {
  --   yamlls = function()
  --     -- Neovim < 0.10 does not have dynamic registration for formatting
  --     if vim.fn.has 'nvim-0.10' == 0 then
  --       LazyVim.lsp.on_attach(function(client, _)
  --         client.server_capabilities.documentFormattingProvider = true
  --       end, 'yamlls')
  --     end
  --   end,
  -- },
}
