-- if true then return {} end

return {
  "mfussenegger/nvim-lint",
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  config = function()
    local lint = require("lint")

    lint.linters_by_ft = {

      fish = { "fish" },
      python = {
        -- Uncomment whichever linters you prefer
        -- 'flake8',
        -- 'mypy',
        "pylint",
      },
      -- javascript = { "eslint_d" },
      -- typescript = { "eslint_d" },
      puppet = { "puppet-lint" },
      -- javascriptreact = { "eslint_d" },
      -- typescriptreact = { "eslint_d" },
      -- svelte = { "eslint_d" },
      dockerfile = { "hadolint" },
      -- terraform = { "tflint" },
      -- ruby = { "standardrb" },
      -- ansible = { "ansible-lint" },
      -- groovy = { "checkstyle" },
      groovy = { "npm-groovy-lint" },
      -- zsh = { "shfmt" },
      -- lua = { "seleme" },
      yaml = { "yamllint" },
      asnible = { "ansible_lint" },
      terraform = { "terraform_validate" },
      tf = { "terraform_validate" },
      ["yaml.gha"] = { "actionlint" },
      zsh = { 'zsh' },
      javascript = { "eslint_d" },
      typescript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      svelte = { "eslint_d" },
      markdown = { "markdownlint-cli2" },

      -- json = { "jsonlint" },
      -- markdown = { "markdownlint" },
      -- Use the "*" filetype to run linters on all filetypes.
      -- ['*'] = { 'global linter' },
      -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
      -- ['_'] = { 'fallback linter' },
      -- ["*"] = { "typos" },
    }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
      group = lint_augroup,
      callback = function()
        lint.try_lint()
      end,
    })

    vim.keymap.set("n", "<leader>l", function()
      lint.try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}
