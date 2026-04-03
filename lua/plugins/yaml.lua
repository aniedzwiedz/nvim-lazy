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
          root_dir = function(fname)
            if type(fname) == "string" and fname:match(".azuredevops/") then
              return require("lspconfig").util.find_git_ancestor(fname)
            end
            return nil
          end,
          single_file_support = true,
          settings = {
            yaml = {
              validate = true,
              schemas = {
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                  "*.azuredevops/**/*.{yaml,yml}",
                  "*azure-pipelines*.{yaml,yml}",
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
          filetypes = { "yaml", "yaml.docker-compose", "yaml.gitlab", "yaml.azure" },
          single_file_support = true,
          before_init = function(_, new_config)
            new_config.settings.yaml.schemas = vim.tbl_deep_extend(
              "force",
              new_config.settings.yaml.schemas or {},
              require("schemastore").yaml.schemas()
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
              schemaStore = {
                enable = true,
                url = "https://www.schemastore.org/json/",
              },
              schemas = {
                -- Azure Pipelines schema for .azuredevops directory
                ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = ".azuredevops/**/*.{yaml,yml}",
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
