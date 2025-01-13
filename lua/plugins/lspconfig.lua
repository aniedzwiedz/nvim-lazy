return {
  "neovim/nvim-lspconfig",
  opts = {
    servers = {
      lua_ls = {
        settings = {
          Lua = {
            runtime = {
              version = "LuaJIT"
            },
            -- ["completion.enable"] = true,
            -- ["hint.enable"] = true,
            -- ["codeLens.enable"] = true,
          },
        }
      },
      puppet = {},
      ts_ls = {
        keys = {
          { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
          { "<leader>cR", "<cmd>TypescriptRenameFile<CR>",      desc = "Rename File" },
        },
      },
      -- sonarlint = {
      --   server = {
      --     cmd = {
      --       'sonarlint-language-server',
      --       -- Ensure that sonarlint-language-server uses stdio channel
      --       '-stdio',
      --       '-analyzers',
      --       -- paths to the analyzers you need, using those for python and java in this example
      --       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarpython.jar"),
      --       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarcfamily.jar"),
      --       vim.fn.expand("$MASON/share/sonarlint-analyzers/sonarjava.jar"),
      --     },
      --   },
      --   filetypes = {
      --     -- Tested and working
      --     'python',
      --     'cpp',
      --     'java',
      --   },
      --   -- settings = {
      --   --   sonarlint = {
      --   --     rules = {
      --   --       ['typescript:S101'] = { level = 'on', parameters = { format = '^[A-Z][a-zA-Z0-9]*$' } },
      --   --       ['typescript:S103'] = { level = 'on', parameters = { maximumLineLength = 180 } },
      --   --       ['typescript:S106'] = { level = 'on' },
      --   --       ['typescript:S107'] = { level = 'on', parameters = { maximumFunctionParameters = 7 } }
      --   --     }
      --   --   },
      --   -- },
      -- },
      -- ruby_lsp = {
      --   enabled = lsp == "ruby_lsp",
      -- },
      -- solargraph = {
      --   enabled = lsp == "solargraph",
      -- },
      -- rubocop = {
      --   enabled = formatter == "rubocop",
      -- },
      -- standardrb = {
      --   enabled = formatter == "standardrb",
      -- },
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
      -- gitlab_ci_ls = {},
      -- jsonls = {
      --   -- lazy-load schemastore when needed
      --   on_new_config = function(new_config)
      --     new_config.settings.json.schemas = new_config.settings.json.schemas or {}
      --     vim.list_extend(new_config.settings.json.schemas, require("schemastore").json.schemas())
      --   end,
      --   settings = {
      --     json = {
      --       format = {
      --         enable = true,
      --       },
      --       validate = { enable = true },
      --     },
      --   },
      -- },
      yamlls = {
        settings = {
          yaml = {
            schemas = {
              ["https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json"] = {
                "*/.azuredevops/**/*.y*ml",
                "*/.azuredevops/**/**/*.y*ml",
              },
              ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
              ["https://raw.githubusercontent.com/instrumenta/kubernetes-json-schema/master/v1.18.0-standalone-strict/all.json"] =
              "/*.k8s.yaml",
              -- ["../path/relative/to/file.yml"] = "/.github/workflows/*",
              -- ["/path/from/root/of/project"] = "/.github/workflows/*",
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
      -- gopls = {
      --   settings = {
      --     gopls = {
      --       hints = {
      --         assignVariableTypes = false,
      --         compositeLiteralFields = false,
      --         compositeLiteralTypes = false,
      --         constantValues = false,
      --         functionTypeParameters = false,
      --         parameterNames = false,
      --         rangeVariableTypes = false,
      --       },
      --     },
      --   },
      -- },
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
