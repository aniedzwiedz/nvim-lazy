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
  "neovim/nvim-lspconfig",
  dependencies = {
    "mason.nvim",
    "williamboman/mason-lspconfig.nvim",
  },
  opts = {
    -- inlay_hints = {
    --   enabled = true,
    -- },
    -- Enable lsp cursor word highlighting
    document_highlight = {
      enabled = true,
    },
    servers = {
      ansiblels = {},
      solargraph = {},
      terraformls = {},
      groovyls = {},
      yamlls = {
        -- cmd = { "yaml-language-server", "--stdio" },
        filetypes = { "yaml" },

        settings = {
          yaml = {
            validate = true,
            -- disable the schema store
            schemaStore = {
              -- enable = false,
              -- url = "",
            },
            schemas = require("schemastore").yaml.schemas {
              kubernetes = { "k8s**.yaml", "kube*/*.yaml" },
              -- select subset from the JSON schema catalog
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              -- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
              ["/conf/jenkins/arn/"] = "/schemas/conf/jenkins/arn/*",
              select = {
                "kustomization.yaml",
                "docker-compose.yml",
              },

              -- additional schemas (not in the catalog)
              extra = {
                url = "https://raw.githubusercontent.com/datreeio/CRDs-catalog/main/argoproj.io/application_v1alpha1.json",
                name = "Argo CD Application",
                fileMatch = "argocd-application.yaml",
              },
            },
          },
        },
      },
      bashls = {
        filetypes = { "sh", "zsh" },
      },
      vimls = {
        filetypes = { "vim" },
      },
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
          vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
        end,
        settings = {
          json = {
            format = {
              enable = true,
            },
            validate = { enable = true },
          },
        },
      },
    },
  },
}
