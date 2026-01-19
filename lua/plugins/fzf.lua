return {
  'ibhagwan/fzf-lua',
  dependencies = { 'nvim-mini/mini.icons' },
  opts = {
    files = {
      cmd = 'fd --type f --hidden --follow --exclude .git',
      multiprocess = true,
      file_icons = true,
      color_icons = true,
    },
    git = {
      split = 'belowright new',
      files = {
        prompt = 'GitFiles-> ',
        cmd = 'git ls-files --exclude-standard',
        multiprocess = true,
        git_icons = true,
        file_icons = true,
        color_icons = true,
      },
    },
    winopts = {
      width = 0.80,
      height = 0.80,
      preview = {
        layout = 'vertical',
        vertical = 'up:70%',
        border = 'rounded',
      },
      previewer = { toggle_behavior = 'extend' },
      treesitter = {
        enabled = true,
        fzf_colors = { ['hl'] = '-1:reverse', ['hl+'] = '-1:reverse' },
      },
    },
    fzf_opts = {
      ['--ansi'] = true,
      ['--info'] = 'inline-right',
      ['--height'] = '100%',
      ['--layout'] = 'reverse',
      ['--highlight-line'] = true,
      ['--bind'] = 'alt-h:toggle-all,space:toggle-all',
    },
    grep = {
      rg_opts = '--color=always --smart-case --hidden --column --line-number',
    },
  },

  keys = {
    {
      '<leader>fd',
      function()
        require('fzf-lua').diagnostics_document()
      end,
      desc = 'Find Diagnostics (fzf)',
    },
  },
}
