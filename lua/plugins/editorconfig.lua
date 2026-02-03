return {
  "editorconfig/editorconfig-vim",
  event = "VeryLazy",
  config = function()
    -- Enable editorconfig support
    vim.g.EditorConfig_exclude_patterns = { 'fugitive://.*', 'scp://.*' }
    
    -- Make sure editorconfig has priority
    vim.g.EditorConfig_enable = 1
  end,
}
