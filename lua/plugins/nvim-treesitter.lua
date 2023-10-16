return {
  "nvim-treesitter/nvim-treesitter",
  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, { "dockerfile" })
      vim.list_extend(opts.ensure_installed, { "markdown", "markdown_inline" })
      vim.list_extend(opts.ensure_installed, { "java" })
    end
  end,
}
