return {
  recommended = function()
    return LazyVim.extras.wants({
      ft = "yaml",
    })
  end,

  -- yaml schema support
  {
    "b0o/SchemaStore.nvim",
    lazy = true,
    version = false,
  },

  -- correctly setup lspconfig
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Azure Pipelines Language Server for .azuredevops files
        azure_pipelines_ls = {
          filetypes = { "yaml.azure" },
          -- root_markers is used by neovim 0.11+ native LSP auto-start to locate the workspace root.
          -- List .azuredevops first so it is preferred over .git for Azure-specific repos.
          root_markers = { ".azuredevops", ".git", "azure-pipelines.yml", "azure-pipeline.yml" },
          single_file_support = true,
          settings = {
            yaml = {
              validate = true,
              schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                  "/azure-pipeline*.y*l",
                  "/*.azure*.y*l",
                  "**/.azuredevops/**/*.{yaml,yml}",
                  "**/.azuredevops/non-production/install/*.{yaml,yml}",
                  "**/azure-pipelines*.{yaml,yml}",
                  "**/azure-pipeline*.{yaml,yml}",
                },
              },
            },
          },
        },
        yamlls = {
          capabilities = {
            textDocument = {
              foldingRange = {
                dynamicRegistration = false,
                lineFoldingOnly = true,
              },
            },
          },
          filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab" },
          single_file_support = true,
          before_init = function(_, new_config)
            -- Disable built-in schemaStore catalog so our explicit schemas are not overridden.
            -- Merge SchemaStore.nvim schemas first, then our explicit schemas win ("force" = last wins).
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              require("schemastore").yaml.schemas(),
              new_config.settings.yaml.schemas or {}
            )
          end,
          settings = {
            redhat = { telemetry = { enabled = false } },
            yaml = {
              keyOrdering = false,
              format = {
                enable = true,
              },
              validate = true,
              -- Must be false when managing schemas manually via SchemaStore.nvim;
              -- enabling it causes yamlls to use its own bundled catalog which can
              -- override or conflict with the schemas set below.
              schemaStore = {
                enable = false,
                url = "",
              },
              schemas = {
                -- Azure Pipelines schema for .azuredevops directory and pipeline files
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                  "**/.azuredevops/**/*.{yaml,yml}",
                  "**/.azuredevops/non-production/install/*.{yaml,yml}",
                  "**/azure-pipelines*.{yaml,yml}",
                  "**/azure-pipeline*.{yaml,yml}",
                },
              },
            },
          },
        },
      },
    },
  },

  -- linting support for yaml
  {
    "mfussenegger/nvim-lint",
    opts = {
      linters_by_ft = {
        yaml = { "yamllint" },
      },
      linters = {
        yamllint = {
          cmd = "yamllint",
          stdin = true,
          stream = "stdout",
          args = {
            "--format", "parsable",
            "--config-data", "{extends: default, rules: {line-length: {max: 120}, document-start: disable, comments: {min-spaces-from-content: 0}, indentation: {spaces: consistent}}}",
            "-"
          },
          ignore_exitcode = true,
          parser = require("lint.parser").from_pattern(
            'stdin:(%d+):(%d+): %[(.+)%] (.+) %((.+)%)',
            { 'lnum', 'col', 'severity', 'message', 'code' },
            { ['error'] = vim.diagnostic.severity.ERROR, ['warning'] = vim.diagnostic.severity.WARN },
            { ['source'] = 'yamllint' }
          ),
          condition = function(ctx)
            local ft = vim.bo[ctx.buf].filetype
            if ft:match("azure") then
              return false
            end
            return true
          end,
        },
      },
    },
  },
}
