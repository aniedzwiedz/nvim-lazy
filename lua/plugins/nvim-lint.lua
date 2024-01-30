-- return {
--   "mfussenegger/nvim-lint",
--   optional = true,
--   opts = {
--     linters_by_ft = {
--       dockerfile = { "hadolint" },
--       markdown = { "markdownlint" },
--       -- gitcommit = { "commitlint" },
--     },
--   },
-- }

return { -- https://github.com/josean-dev/dev-environment-files/blob/main/.config/nvim/lua/josean/plugins/linting.lua
  "mfussenegger/nvim-lint",
  events = { "BufWritePost", "BufReadPost", "InsertLeave" },
  config = function()
    -- Define a table of linters for each filetype (not extension).
    -- Additional linters can be found here: https://github.com/mfussenegger/nvim-lint#available-linters
    require("lint").linters_by_ft = {
      python = {
        -- Uncomment whichever linters you prefer
        -- 'flake8',
        -- 'mypy',
        "pylint",
      },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      puppet = { "puppet-lint" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      dockerfile = { "hadolint" },
      terraform = { "tflint" },
      ruby = { "standardrb" },
      ansible = { "ansible_lint" },
      -- groovy = { "checkstyle" },
      groovy = { "npm-groovy-lint" },
      zsh = { "beautysh" },
      lua = { "luacheck" },
      yaml = { "yamllint" },
      asnible = { "ansible_lint" },
      json = { "jsonlint" },
      markdown = { "markdownlint" },
    }

    -- Automatically run linters after saving.  Use "InsertLeave" for more aggressive linting.
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      -- Only run linter for the following extensions. Remove this to always run.
      pattern = { "*.py" },
      callback = function()
        require("lint").try_lint()
      end,
    })
  end,

  -- lazy = true,
  -- event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  -- config = function()
  --   local lint = require("lint")
  --
  --   lint.linters_by_ft = {
  --     javascript = { "eslint_d" },
  --     typescript = { "eslint_d" },
  --     javascriptreact = { "eslint_d" },
  --     typescriptreact = { "eslint_d" },
  --     svelte = { "eslint_d" },
  --     python = { "pylint" },
  --     dockerfile = { "hadolint" },
  --     markdown = { "markdownlint" },
  --             terraform = { "tflint" },
  -- ruby = { "standardrb" },

  --   }
  --
  --   local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })
  --
  --   vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
  --     group = lint_augroup,
  --     callback = function()
  --       lint.try_lint()
  --     end,
  --   })
  --
  --   vim.keymap.set("n", "<leader>cL", function()
  --     lint.try_lint()
  --   end, { desc = "Trigger linting for current file" })
  -- end,
  --
}
