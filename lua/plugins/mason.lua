return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    -- opts = function(_, opts)
    --   opts.ensure_installed = opts.ensure_installed or {}
    --   vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman", "stylua", "shellcheck", "shfmt" })
    --   vim.list_extend(opts.ensure_installed, { "java-test", "java-debug-adapter" })
    -- end,
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
      ensure_installed = {
        "shellcheck",
        "shfmt",
        "flake8",
        "markdownlint",
        "marksman",
        "hadolint", -- docker mason
        "java-test",
        "java-debug-adapter",
        "solargraph",
        "shellcheck",
        "clangd",
        "codelldb",
        "commitlint",
        "css-lsp",
        "html-lsp",
        "tailwindcss-language-server",
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    },
  },
}
