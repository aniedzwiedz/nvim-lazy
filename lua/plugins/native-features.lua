-- Disable plugins that duplicate native Neovim 0.10+ features
-- NVIM v0.13.0 has built-in support for:
-- - Comments (gc, gcc motions)
-- - Snippets (vim.snippet)
-- - Inlay hints (vim.lsp.inlay_hint)
-- - EditorConfig (runtime/plugin/editorconfig.lua)

return {
  -- Disable ts-comments.nvim - use native commenting (gc, gcc) since 0.10+
  {
    'folke/ts-comments.nvim',
    enabled = false,
  },

  -- Disable mini.comment if present - native commenting is better
  {
    'nvim-mini/mini.comment',
    enabled = false,
  },

  -- Note: LazyVim uses vim.g.lazyvim_mini_snippets_in_completion = true
  -- which leverages native snippets. friendly-snippets provides snippet
  -- definitions that work with native vim.snippet, so we keep it.
}
