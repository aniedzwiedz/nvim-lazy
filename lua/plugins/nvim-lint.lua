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
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      python = { "pylint" },
      dockerfile = { "hadolint" },
      markdown = { "markdownlint" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>cL", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
