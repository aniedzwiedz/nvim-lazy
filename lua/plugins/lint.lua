-- if true then return {} end

return {
  {
    "mfussenegger/nvim-lint",
    -- table.insert(opts.sections.lualine_x, "😄")
    opts = {
      linters_by_ft = {
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

        -- json = { "jsonlint" },
        -- markdown = { "markdownlint" },
        -- Use the "*" filetype to run linters on all filetypes.
        -- ['*'] = { 'global linter' },
        -- Use the "_" filetype to run linters on filetypes that don't have other linters configured.
        -- ['_'] = { 'fallback linter' },
        -- ["*"] = { "typos" },
      },
    },
  },
}
