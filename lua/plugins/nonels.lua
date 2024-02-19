return {
  "nvimtools/none-ls.nvim",
  event = { "BufReadPre", "BufNewFile" },
  dependencies = {
    "jay-babu/mason-null-ls.nvim",
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local mason_null_ls = require("mason-null-ls")
    local null_ls = require("null-ls")

    local null_ls_utils = require("null-ls.utils")

    mason_null_ls.setup({
      ensure_installed = {
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "eslint_d", -- js linter
        -- "golangci_lint", -- go linter
        "terraform_fmt", -- terraform formatter
        "terraform_validate", -- terraform linter
        "shellcheck", -- shell linter
        "yamllint", -- yaml linter
        "buf", -- buf formatter
        "beautysh", -- shell formatter
        -- "gofumpt", -- go formatter
        "yamlfmt", -- yaml formatter
        "spell", -- spell checker
        "black", -- python formatter
      },
    })

    local formatting = null_ls.builtins.formatting
    local diagnostics = null_ls.builtins.diagnostics
    -- local code_actions = null_ls.builtins.code_actions
    -- local augroup = vim.api.nvim_create_augroup("LspFormatting", {})
    --
    local conditional = function(fn)
      local utils = require("null-ls.utils").make_conditional_utils()
      return fn(utils)
    end

    null_ls.setup({
      root_dir = null_ls_utils.root_pattern(".null-ls-root", "Makefile", ".git", "package.json"),
      debug = false,

      sources = {
        formatting.stylua,
        formatting.prettier.with({
          filetypes = { "html", "json", "yaml", "markdown", "vue" },
        }),
        -- formatting.gofumpt,
        formatting.terraform_fmt,
        formatting.buf,
        formatting.beautysh,
        -- formatting.yamlfmt,
        formatting.black,
        formatting.rubocop,

        -- diagnostics.eslint_d,
        diagnostics.eslint_d.with({ -- js/ts linter
          condition = function(utils)
            return utils.root_has_file({ ".eslintrc.js", ".eslintrc.cjs" }) -- only enable if root has .eslintrc.js or .eslintrc.cjs
          end,
        }),
        -- diagnostics.golangci_lint,
        diagnostics.terraform_validate,
        diagnostics.shellcheck,
        diagnostics.yamllint,
        diagnostics.luacheck,
        diagnostics.puppet_lint,
        -- Here we set a conditional to call the rubocop formatter. If we have a Gemfile in the project, we call "bundle exec rubocop", if not we only call "rubocop".
        conditional(function(utils)
          return utils.root_has_file("Gemfile")
              and null_ls.builtins.formatting.rubocop.with({
                command = "bundle",
                args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.formatting.rubocop._opts.args),
              })
            or null_ls.builtins.formatting.rubocop
        end),

        -- Same as above, but with diagnostics.rubocop to make sure we use the proper rubocop version for the project
        conditional(function(utils)
          return utils.root_has_file("Gemfile")
              and null_ls.builtins.diagnostics.rubocop.with({
                command = "bundle",
                args = vim.list_extend({ "exec", "rubocop" }, null_ls.builtins.diagnostics.rubocop._opts.args),
              })
            or null_ls.builtins.diagnostics.rubocop
        end),

        -- code_actions.gitsigns,
        -- code_actions.refactoring,
      },
      -- configure format on save
      -- on_attach = function(current_client, bufnr)
      --   if current_client.supports_method("textDocument/formatting") then
      --     vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
      --     vim.api.nvim_create_autocmd("BufWritePre", {
      --       group = augroup,
      --       buffer = bufnr,
      --       callback = function()
      --         vim.lsp.buf.format({
      --           filter = function(client)
      --             --  only use null-ls for formatting instead of lsp server
      --             return client.name == "null-ls"
      --           end,
      --           bufnr = bufnr,
      --         })
      --       end,
      --     })
      --   end
      -- end,
    })
  end,
}
