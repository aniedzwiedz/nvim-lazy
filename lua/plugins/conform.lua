

if true then return {
-- NOTE: added in nonels.lua

} end

return {
  "stevearc/conform.nvim", -- https://github.com/stevearc/conform.nvim formatter plugin
  -- -- optional = true,
  lazy = true,
  event = { "BufReadPre", "BufNewFile" }, -- to disable, comment this out
  opts = {
    formatters_by_ft = {
      lua = { "stylua" },
      svelte = { { "prettierd", "prettier" } },
      javascript = { "prettier" },
      typescript = { "prettier" },
      javascriptreact = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      json = { "prettier" },
      graphql = { { "prettierd", "prettier" } },
      java = { "google-java-format" },
      kotlin = { "ktlint" },
      ruby = { "standardrb" },
      -- markdown = { { "prettierd", "prettier" } },
      markdown = { "prettier" },
      erb = { "htmlbeautifier" },
      html = { "htmlbeautifier" },
      bash = { "beautysh" },
      proto = { "buf" },
      rust = { "rustfmt" },
      -- yaml = { "yamlfix" },
      yaml = { "prettier" },
      toml = { "taplo" },
      terraform = { "terraform_fmt" },
      tf = { "terraform_fmt" },
      ["terraform-vars"] = { "terraform_fmt" },
      css = { { "prettierd", "prettier" } }, --   })
      --     -- Conform will run multiple formatters sequentially
      --     go = { "goimports", "gofmt" },
      --     -- Use a sub-list to run only the first available formatter
      --     javascript = { { "prettierd", "prettier" } },
      --     -- You can use a function here to determine the formatters dynamically
      python = function(bufnr)
        if require("conform").get_formatter_info("ruff_format", bufnr).available then
          return { "ruff_format" }
        else
          return { "isort", "black" }
        end
      end,
      --     -- Use a sub-list to run only the first available formatter
      --     ["_"] = { "trim_whitespace" },
      --     typescript = { "prettier" },
      --     javascriptreact = { "prettier" },
      --     typescriptreact = { "prettier" },
      --     svelte = { "prettier" },
      --     css = { "prettier" },
      --     html = { "prettier" },
      --     json = { "prettier" },
      --     yaml = { "prettier" },
      --     markdown = { "prettier" },
      --     graphql = { "prettier" },
      --     terraform = { "terraform_fmt" },
      --     tf = { "terraform_fmt" },
      --     ["terraform-vars"] = { "terraform_fmt" },
      --   },
    },
  },
  -- format_on_save = {
  --   lsp_fallback = true,
  --   async = false,
  --   timeout_ms = 500,
  -- },
  --
  -- notify_on_error = true,

  --   vim.keymap.set({ "n", "v" }, "<space>bf", function() -- TODO: check this one
  --     conform.format({
  --       timeout_ms = 500,
  --       async = false,
  --       -- lsp_fallback = true,
  --       lsp_fallback = false,
  --     })
  --   end, { desc = "Buffer format" }),
  --

  -- { -- https://github.com/exosyphon/nvim/blob/main/lua/exosyphon/lazy.lua
  --   "stevearc/conform.nvim",
  --   event = { "BufReadPre", "BufNewFile" },
  -- config = function()
  --   local conform = require("conform")
  --
  --   conform.setup({
  --     formatters_by_ft = {
  --       lua = { "stylua" },
  --       svelte = { { "prettierd", "prettier" } },
  --       javascript = { { "prettierd", "prettier" } },
  --       typescript = { { "prettierd", "prettier" } },
  --       javascriptreact = { { "prettierd", "prettier" } },
  --       typescriptreact = { { "prettierd", "prettier" } },
  --       json = { { "prettierd", "prettier" } },
  --       graphql = { { "prettierd", "prettier" } },
  --       java = { "google-java-format" },
  --       kotlin = { "ktlint" },
  --       ruby = { "standardrb" },
  --       markdown = { { "prettierd", "prettier" } },
  --       erb = { "htmlbeautifier" },
  --       html = { "htmlbeautifier" },
  --       bash = { "beautysh" },
  --       proto = { "buf" },
  --       rust = { "rustfmt" },
  --       yaml = { "yamlfix" },
  --       toml = { "taplo" },
  --       css = { { "prettierd", "prettier" } }   --   })
  --
  --   vim.keymap.set({ "n", "v" }, "<leader>l", function()
  --     conform.format({
  --       lsp_fallback = true,
  --       async = false,
  --       timeout_ms = 500,
  --     })
  --   end, { desc = "Format file or range (in visual mode)" })
  -- end,
  -- },
}
