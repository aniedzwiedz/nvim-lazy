return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "dockerfile" })
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      vim.list_extend(opts.ensure_installed, { "java" })
    end
  end,
  indent = {
    enable = true,
  },
  autotag = {
    enable = true,
  },
  event = {
    "BufReadPre",
    "BufNewFile",
  },
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },
}
