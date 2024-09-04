return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      tsserver = {
        keys = {
          { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
          { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
        },
      },
      --   azure_pipelines_ls = {
      --     settings = {
      --       yaml = {
      --         schemas = {
      --           ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
      --             "/azure-pipeline*.y*l",
      --             "/*.azure*",
      --             "Azure-Pipelines/**/*.y*l",
      --             "Pipelines/*.y*l",
      --           },
      --         },
      --       },
      --     },
      --   },
      -- },
      -- azure_pipelines_ls = {
      -- yamlls = {
      --   settings = {
      --     yaml = {
      --       schemas = {
      --         ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
      --           "*/.azuredevops/**/*.y*ml",
      --           "/azure-pipeline*.y*l",
      --           "/*.azure*",
      --           "Azure-Pipelines/**/*.y*l",
      --           "Pipelines/*.y*l",
      --         },
      --       },
      --     },
      --   },
      -- },
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                "*/.azuredevops/**/*.y*ml",
              },
            },
          },
        },
      },
      harper_ls = { -- https://github.com/elijah-potter/harper/blob/master/harper-ls/README.md
        settings = {
          ["harper-ls"] = {
            userDictPath = "~/harper_ls-dir.txt",
            diagnosticSeverity = "hint", -- Can also be "information", "warning", or "error"
            linters = {
              spell_check = false,
              spelled_numbers = false,
              an_a = false,
              sentence_capitalization = false,
              unclosed_quotes = true,
              wrong_quotes = false,
              long_sentences = false,
              repeated_words = true,
              spaces = true,
              matcher = true,
              correct_number_suffix = false,
              number_suffix_capitalization = false,
              multiple_sequential_pronouns = true,
            },
            codeActions = {
              forceStable = true,
            },
          },
        },
      },
      gopls = {
        settings = {
          gopls = {
            hints = {
              assignVariableTypes = false,
              compositeLiteralFields = false,
              compositeLiteralTypes = false,
              constantValues = false,
              functionTypeParameters = false,
              parameterNames = false,
              rangeVariableTypes = false,
            },
          },
        },
      },
      -- vtsls = {
      --   settings = {
      --     typescript = {
      --       inlayHints = {
      --         enumMemberValues = { enabled = false },
      --         functionLikeReturnTypes = { enabled = false },
      --         parameterNames = { enabled = false },
      --         parameterTypes = { enabled = false },
      --         propertyDeclarationTypes = { enabled = false },
      --         variableTypes = { enabled = false },
      --       },
      --     },
      --   },
      -- },
    },
  },
}
