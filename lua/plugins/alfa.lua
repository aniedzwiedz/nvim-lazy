return {

  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    -- opts = function()
    opts = function(_, opts)
      ---@type snacks.Config
      return {
        notifier = {
          enabled = true,
          timeout = 3000, -- default timeout in ms
          width = { min = 40, max = 0.4 },
          height = { min = 1, max = 0.6 },
          -- editor margin to keep free. tabline and statusline are taken into account automatically
          margin = { top = 0, right = 1, bottom = 0 },
          padding = true, -- add 1 cell of left/right padding to the notification window
          sort = { "level", "added" }, -- sort by level and time
          -- minimum log level to display. TRACE is the lowest
          -- all notifications are stored in history
          level = vim.log.levels.TRACE,
          icons = {
            error = " ",
            warn = " ",
            info = " ",
            debug = " ",
            trace = " ",
          },
          keep = function(notif)
            return vim.fn.getcmdpos() > 0
          end,
          ---@type snacks.notifier.style
          style = "compact",
          top_down = true, -- place notifications from top to bottom
          date_format = "%R", -- time format for notifications
          -- format for footer when more lines are available
          -- `%d` is replaced with the number of lines.
          -- only works for styles with a border
          ---@type string|boolean
          more_format = " ↓ %d lines ",
          refresh = 50, -- refresh at most every 50ms
        },
        dashboard = {
          width = 80,
          -- row = 20, -- dashboard position. nil for center
          -- col = 20, -- dashboard position. nil for center
          pane_gap = 4, -- empty columns between vertical panes
          enabled = true,
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
          -- stylua: ignore
          ---@type snacks.dashboard.Item[]
          keys = {
            { icon = " ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
            -- { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            { icon = " ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
            { icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
            { icon = " ", key = "c", desc = "Config", action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})" },
            { icon = " ", key = "s", desc = "Restore Session", section = "session" },
            { icon = " ", key = "x", desc = "Lazy Extras", action = ":LazyExtras" },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
          },
          sections = {
            { section = "header" },
            { section = "keys", pane = 2, padding = 1 },
            { pane = 2, icon = " ", title = "Recent Files", section = "recent_files", indent = 3, padding = 1 },
            { pane = 2, icon = " ", title = "Projects", section = "projects", indent = 3, padding = 1 },
            {
              pane = 2,
              icon = " ",
              title = "Git Status",
              section = "terminal",
              enabled = Snacks.git.get_root() ~= nil,
              -- cmd = "git log --pretty=oneline -n 5 --graph --abbrev-commit ",
              cmd = "git log --decorate -n 5 --pretty=oneline --abbrev-commit",
              height = 5,
              padding = 1,
              ttl = 5 * 60,
              indent = 3,
            },
            { section = "startup" },
          },
        },
        bigfile = { enabled = true },
        quickfile = { enabled = true },
        statuscolumn = { enabled = false }, -- we set this in options.lua
        terminal = { enabled = true },
        rename = { enabled = true },
        toggle = { map = LazyVim.safe_keymap_set },
        words = { enabled = true },
      }
    end,
    -- keys = {
    --   {
    --     "<leader>un",
    --     function()
    --       Snacks.notifier.hide()
    --     end,
    --     desc = "Dismiss All Notifications",
    --   },
    -- },
  },


}
