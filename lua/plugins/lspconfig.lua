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
        harper_ls = { -- https://github.com/elijah-potter/harper/blob/master/harper-ls/README.md
          settings = {
            ["harper-ls"] = {
              userDictPath = "~/harper_ls-dir.txt",
              diagnosticSeverity = "hint", -- Can also be "information", "warning", or "error"
              linters = {
                spelled_numbers = true,
                number_suffix_capitalization = false,
                sentence_capitalization = false,
                an_a = false,
                long_sentences = true,
                repeated_words = true,
                spaces = true,
                matcher = true,
                correct_number_suffix = false,
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
