-- return { 'vague2k/vague.nvim', opts = {
--   transparent =true,
-- } }
--
-- return {"ramojus/mellifluous.nvim",
return {
  {
    'vague2k/vague.nvim',
    config = function()
      require('vague').setup { transparent = true }
      vim.cmd 'colorscheme vague'
      vim.cmd ':hi statusline guibg=NONE'
    end,
  },

  -- FIX: https://github.com/LazyVim/LazyVim/issues/6355#issuecomment-3212986215
  -- {
  --   'catppuccin/nvim',
  --   opts = function(_, opts)
  --     local module = require 'catppuccin.groups.integrations.bufferline'
  --     if module then
  --       module.get = module.get_theme
  --     end
  --     return opts
  --   end,
  -- },
}
