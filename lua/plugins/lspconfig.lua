return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        tsserver = {
          keys = {
            { "<leader>co", "<cmd>TypescriptOrganizeImports<CR>", desc = "Organize Imports" },
            { "<leader>cR", "<cmd>TypescriptRenameFile<CR>", desc = "Rename File" },
          },
        },
        harper_ls = {
          settings = {
            ["harper-ls"] = {
              userDictPath = "~/harper_ls-dir.txt",
              diagnosticSeverity = "hint", -- Can also be "information", "warning", or "error"
              linters = {
                spelled_numbers = true,
                number_suffix_capitalization = false,
                sentence_capitalization = false,
              },
              codeActions = {
                forceStable = true,
              },
            },
          },
        },
      },
    },
  },
}
