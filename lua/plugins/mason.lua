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
        "stylua",
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
      },
    },
  },
}
