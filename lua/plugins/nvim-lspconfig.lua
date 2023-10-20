return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      marksman = {},
      dockerls = {},
      docker_compose_language_service = {},
      jdtls = {},
      puppet = {

        cmd = {
          "puppet-languageserver",
          "--stdio",
          "--puppet-settings=--modulepath,/code/a32-tools:/code/puppet:/code/puppet-forge",
        },
      },
    },
    json = {
      schemas = require("schemastore").json.schemas({
        select = {
          ".eslintrc",
          "package.json",
        },
      }),
      validate = { enable = true },
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
      },
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
            ["schemas/conf/jenkins/arn/streams.json"] = "conf/jenkins/arn/config.yaml",
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
    setup = {
      jdtls = function()
        return true -- avoid duplicate servers
      end,
    },
  },
}
