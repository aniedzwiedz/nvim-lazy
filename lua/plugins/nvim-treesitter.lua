return {
  "nvim-treesitter/nvim-treesitter",

    -- opts = function(_, opts)  -- NOTE: dodatkowe opcje konfigu
    --   -- add tsx and treesitter
    --   vim.list_extend(opts.ensure_installed, {
    --     "tsx",
    --     "typescript",
    --   })
    -- end,

  opts = function(_, opts)
    if type(opts.ensure_installed) == "table" then
      vim.list_extend(opts.ensure_installed, {
        "dockerfile",
        "java",
        "markdown",
        "markdown_inline",
        "terraform",
        "hcl",
        "ninja",
        "python",
        "rst",
        "toml",
        "json",
        "json5",
        "jsonc",
        "ruby",
        "typescript",
        "tsx",
      })
      -- vim.list_extend(opts.ensure_installed, { "ninja", "python", "rst", "toml" })
      -- vim.list_extend(opts.ensure_installed, { "json", "json5", "jsonc", "ruby" })
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
