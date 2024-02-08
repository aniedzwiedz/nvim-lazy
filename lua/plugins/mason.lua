return {
  -- add any tools you want to have installed below
  {
    "williamboman/mason.nvim",
    dependencies = {
      "williamboman/mason-lspconfig.nvim",
    },
    -- opts = function(_, opts)  -- NOTE: test config function way with default
    --   opts.ensure_installed = opts.ensure_installed or {}
    --   vim.list_extend(opts.ensure_installed, { "markdownlint", "marksman", "stylua", "shellcheck", "shfmt" })
    --   vim.list_extend(opts.ensure_installed, { "java-test", "java-debug-adapter" })
    -- end,
    --
    --   config = function()   -- NOTE: set config function way
    -- require('mason').setup {
    --   ui = {
    --     icons = {
    --       package_installed = '✓',
    --       package_pending = '➜',
    --       package_uninstalled = '✗',
    --     },
    --   },
    -- }

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
        "beautysh",
        "shfmt",
        -- "beautysh",
        "flake8",
        "yamllint",
        "js-debug-adapter",
        "markdownlint",
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
        "marksman",
        -- "quick_lint_js",
        "pyright",
        "rust-analyzer",
        "prettier", -- prettier formatter
        "stylua", -- lua formatter
        "luacheck", 
        "isort", -- python formatter
        "black", -- python formatter
        "pylint", -- python linter
        "eslint_d", -- js linter
        "debugpy",
        "flake8",
        "isort",
        "mypy",
        "pylint",
      },
      -- auto-install configured servers (with lspconfig)
      automatic_installation = true, -- not the same as ensure_installed
    },
  },
}
