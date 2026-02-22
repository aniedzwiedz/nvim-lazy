return {
  'folke/snacks.nvim',
  event = 'VeryLazy',
  priority = 1000,
  opts = {
    dashboard = {
      width = 60,
      autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ',
      preset = {
        header = [[

                      > <     ,     > <
                 .     '             '      .      .
                          __.--._          > <
                  .     .'   L   `.--._     '
                 > <    `/ c '`    \   `.
                  '     :           ;    `.    `     ,
                        |           ;      \
                       /`.     | ' /        \     .
                  '   / -.\ \  ^ ;/   _      \   > <
                     :    \`.:/ \|     `.|    ;   '
                     |     :''   '       ;    |
                     |     |`.         _/_    ;
                     :     :  `-._____/   `. /
                      \    |         :/ ,   V\
            /"\   __.--; _ :         `./ /  ; ;
           :  |\_/     |  \L  _..--.   `.L.'  |`.   __
           |  | ;`.    ; _ \\'      `.          /`+'.'`.
           |  | |      | \CT_;        `-.      ' / /   |
           |-_| |   .-'`.___.            `-.    / /    ;
           :  ; :.-'                        `-./ /.   /
            \/_/         _                     \/  `./
             "                                  `._.'
    ]],
      },
      sections = {
        { section = 'header' },
        { section = 'keys', pane = 2, gap = 0, padding = 1 },
        {
          pane = 2,
          icon = ' ',
          title = 'Recent Files',
          section = 'recent_files',
          indent = 1,
          padding = 0,
        },
        {
          pane = 2,
          icon = ' ',
          title = 'Git Status',
          section = 'terminal',
          enabled = function()
            return Snacks.git.get_root() ~= nil
          end,
          cmd = 'git status --short --branch --renames',
          height = 6,
          padding = 1,
          ttl = 5 * 60,
          indent = 3,
        },
        { section = 'startup' },
      },
    },

    picker = {
      transform = function(item)
        if not item.file then
          return item
        end
        if item.file:match 'lazyvim/lua/config/keymaps%.lua' then
          item.score_add = (item.score_add or 0) - 30
        end
        return item
      end,
      sources = {
        gh_issue = { layout = 'telescope' },
        gh_pr = { layout = 'telescope' },
        files = { hidden = true },
        git_files = { hidden = true },
      },
      layout = {
        preset = 'vertical',
        cycle = true,
      },
      layouts = {
        ivy = {
          layout = {
            box = 'vertical',
            backdrop = false,
            row = -1,
            width = 0,
            height = 0.7,
            border = 'top',
            title = ' {title} {live} {flags}',
            title_pos = 'left',
            { win = 'input', height = 1, border = 'bottom' },
            {
              box = 'horizontal',
              { win = 'list', border = 'none' },
              {
                win = 'preview',
                title = '{preview}',
                width = 0.5,
                border = 'left',
              },
            },
          },
        },
        vertical = {
          layout = {
            backdrop = false,
            width = 0.8,
            min_width = 80,
            height = 0.8,
            min_height = 30,
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            { win = 'list', border = 'none' },
            {
              win = 'preview',
              title = '{preview}',
              height = 0.4,
              border = 'top',
            },
          },
        },
        telescope = {
          layout = {
            backdrop = false,
            width = 0.9,
            min_width = 100,
            height = 0.85,
            min_height = 30,
            box = 'vertical',
            border = 'rounded',
            title = '{title} {live} {flags}',
            title_pos = 'center',
            { win = 'input', height = 1, border = 'bottom' },
            {
              box = 'horizontal',
              { win = 'list', width = 0.45, border = 'none' },
              {
                win = 'preview',
                title = '{preview}',
                width = 0.55,
                border = 'left',
              },
            },
          },
        },
      },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
            ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
          },
        },
      },
    },

    words = { enabled = true },

    lazygit = {
      configure = true,
      win = {
        width = 0,
        height = 0.95,
        style = 'lazygit',
      },
    },

    styles = {
      snacks_image = {
        relative = 'editor',
        col = -1,
      },
    },

    gitbrowse = {
      notify = true,
      open = function(url)
        if vim.fn.has 'nvim-0.10' == 0 then
          require('lazy.util').open(url, { system = true })
          return
        end
        vim.ui.open(url)
      end,
      what = 'commit',
    },

    gh = {},
  },
  keys = {
    {
      '<leader>gi',
      function()
        Snacks.picker.gh_issue()
      end,
      desc = 'GitHub Issues (open)',
    },
    {
      '<leader>gI',
      function()
        Snacks.picker.gh_issue { state = 'all' }
      end,
      desc = 'GitHub Issues (all)',
    },
    {
      '<leader>gp',
      function()
        Snacks.picker.gh_pr()
      end,
      desc = 'GitHub Pull Requests (open)',
    },
    {
      '<leader>gP',
      function()
        Snacks.picker.gh_pr { state = 'all' }
      end,
      desc = 'GitHub Pull Requests (all)',
    },
    {
      '<M-g>',
      function()
        Snacks.picker.git_branches {
          layout = 'select',
        }
      end,
      desc = 'Branches',
    },
    {
      '<M-k>',
      function()
        Snacks.picker.keymaps {
          layout = 'vertical',
        }
      end,
      desc = 'Keymaps',
    },
    {
      '<S-b>',
      function()
        Snacks.picker.buffers {
          layout = 'vertical',
          on_show = function()
            vim.cmd.stopinsert()
          end,
          finder = 'buffers',
          format = 'buffer',
          hidden = false,
          unloaded = true,
          current = true,
          sort_lastused = true,
          win = {
            input = {
              keys = {
                ['d'] = 'bufdelete',
              },
            },
            list = { keys = { ['d'] = 'bufdelete' } },
          },
        }
      end,
      desc = '[P]Snacks picker buffers',
    },
  },
}
