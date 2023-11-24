return {
  "stevearc/conform.nvim",
  optional = true,
  opts = {
    formatters_by_ft = {
      -- ["javascriptreact"] = { "prettier" },
      -- ["typescript"] = { "prettier" },
      -- ["typescriptreact"] = { "prettier" },
      -- ["vue"] = { "prettier" },
      -- ["css"] = { "prettier" },
      -- ["scss"] = { "prettier" },
      -- ["less"] = { "prettier" },
      -- ["html"] = { "prettier" },
      -- ["json"] = { "prettier" },
      -- ["jsonc"] = { "prettier" },
      -- ["yaml"] = { "prettier" },
      -- ["markdown"] = { "prettier" },
      -- ["markdown.mdx"] = { "prettier" },
      -- ["graphql"] = { "prettier" },
      -- ["handlebars"] = { "prettier" },

      lua = { "stylua" },
      -- You can use a function here to determine the formatters dynamically
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      -- Use a sub-list to run only the first available formatter
      javascript = { { "prettierd", "prettier" } },
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },
      ["terraform-vars"] = { "terraform_fmt" },
    },
  },
}
