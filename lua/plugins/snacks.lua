-- if true then
--   return {}
-- end

return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  opts = {
    indent = {
      -- priority = 1,
      enabled = false, -- enable indent guides
      char = '╎',
      only_scope = true, -- only show indent guides of the scope
      only_current = false, -- only show indent guides in the current window
      hl = 'SnacksIndent', ---@type string|string[] hl groups for indent guides
      -- can be a list of hl groups to cycle through
      -- hl = {
      --     "SnacksIndent1",
      --     "SnacksIndent2",
      --     "SnacksIndent3",
      --     "SnacksIndent4",
      --     "SnacksIndent5",
      --     "SnacksIndent6",
      --     "SnacksIndent7",
      --     "SnacksIndent8",
      -- },
    },

    dashboard = {
      width = 60,
      row = nil, -- dashboard position. nil for center
      col = nil, -- dashboard position. nil for center
      -- pane_gap = 4, -- empty columns between vertical panes
      autokeys = '1234567890abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ', -- autokey sequence
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
        -- {
        --   pane = 2,
        --   icon = ' ',
        --   title = 'Projects',
        --   section = 'projects',
        --   indent = 2,
        --   padding = 1,
        -- },
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

    -- Documentation for the picker
    -- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
    picker = {
      -- My ~/github/dotfiles-latest/neovim/lazyvim/lua/config/keymaps.lua
      -- file was always showing at the top, I needed a way to decrease its
      -- score, in frecency you could use :FrecencyDelete to delete a file
      -- from the database, here you can decrease it's score
      transform = function(item)
        if not item.file then
          return item
        end
        -- Demote the "lazyvim" keymaps file:
        if item.file:match 'lazyvim/lua/config/keymaps%.lua' then
          item.score_add = (item.score_add or 0) - 30
        end
        -- Boost the "neobean" keymaps file:
        -- if item.file:match("neobean/lua/config/keymaps%.lua") then
        --   item.score_add = (item.score_add or 0) + 100
        -- end
        return item
      end,
      sources = {
        files = {
          hidden = true,
        },
        git_files = {
          hidden = true,
        },
        -- explorer = {
        -- layout = { layout = { position = "left" } },
        layout = 'vertical',
        -- },
      },

      -- In case you want to make sure that the score manipulation above works
      -- or if you want to check the score of each file
      debug = {
        scores = false, -- don't show scores in the list
      },
      -- I like the "ivy" layout, so I set it as the default globaly, you can
      -- still override it in different keymaps
      layout = {
        preset = 'ivy',
        -- preset = 'vertical',
        -- When reaching the bottom of the results in the picker, I don't want
        -- it to cycle and go back to the top
        cycle = true,
      },
      layouts = {
        -- I wanted to modify the ivy layout height and preview pane width,
        -- this is the only way I was able to do it
        -- NOTE: I don't think this is the right way as I'm declaring all the
        -- other values below, if you know a better way, let me know
        --
        -- Then call this layout in the keymaps above
        -- got example from here
        -- https://github.com/folke/snacks.nvim/discussions/468
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
        -- I wanted to modify the layout width
        --
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
      },
      matcher = {
        frecency = true,
      },
      win = {
        input = {
          keys = {
            -- to close the picker on ESC instead of going to normal mode,
            -- add the following keymap to your config
            ['<Esc>'] = { 'close', mode = { 'n', 'i' } },
            -- I'm used to scrolling like this in LazyGit
            ['J'] = { 'preview_scroll_down', mode = { 'i', 'n' } },
            ['K'] = { 'preview_scroll_up', mode = { 'i', 'n' } },
            ['H'] = { 'preview_scroll_left', mode = { 'i', 'n' } },
            ['L'] = { 'preview_scroll_right', mode = { 'i', 'n' } },
          },
        },
      },
    },
    words = { enabled = true },
    explorer = { enabled = false },

    -- Folke pointed me to the snacks docs
    -- https://github.com/LazyVim/LazyVim/discussions/4251#discussioncomment-11198069
    -- Here's the lazygit snak docs
    -- https://github.com/folke/snacks.nvim/blob/main/docs/lazygit.md
    lazygit = {
      configure = true,
      -- theme = {
      -- },
      -- With this I make lazygit to use the entire screen, because by default there's
      -- "padding" added around the sides
      -- I asked in LazyGit, folke didn't like it xD xD xD
      -- https://github.com/folke/snacks.nvim/issues/719
      win = {
        -- -- The first option was to use the "dashboard" style, which uses a
        -- -- 0 height and width, see the styles documentation
        -- -- https://github.com/folke/snacks.nvim/blob/main/docs/styles.md
        -- style = "dashboard",
        -- But I can also explicitly set them, which also works, what the best
        -- way is? Who knows, but it works
        width = 0,
        height = 0.95,
        style = 'lazygit',
      },
    },
    notifier = {
      enabled = false,
      -- top_down = true, -- place notifications from top to bottom
    },
    -- This keeps the image on the top right corner, basically leaving your
    -- text area free, suggestion found in reddit by user `Redox_ahmii`
    -- https://www.reddit.com/r/neovim/comments/1irk9mg/comment/mdfvk8b/?utm_source=share&utm_medium=web3x&utm_name=web3xcss&utm_term=1&utm_content=share_button
    styles = {
      snacks_image = {
        relative = 'editor',
        col = -1,
      },
    },
    gitbrowse = {
      notify = true, -- show notification on open
      -- Handler to open the url in a browser
      ---@param url string
      open = function(url)
        if vim.fn.has 'nvim-0.10' == 0 then
          require('lazy.util').open(url, { system = true })
          return
        end
        vim.ui.open(url)
      end,
      ---@type "repo" | "branch" | "file" | "commit" | "permalink"
      what = 'commit', -- what to open. not all remotes support all types
      branch = nil, ---@type string?
      line_start = nil, ---@type number?
      line_end = nil, ---@type number?
      -- patterns to transform remotes to an actual URL
      remote_patterns = {
        { '^(https?://.*)%.git$', '%1' },
        { '^git@(.+):(.+)%.git$', 'https://%1/%2' },
        { '^git@(.+):(.+)$', 'https://%1/%2' },
        { '^git@(.+)/(.+)$', 'https://%1/%2' },
        { '^org%-%d+@(.+):(.+)%.git$', 'https://%1/%2' },
        { '^ssh://git@(.*)$', 'https://%1' },
        { '^ssh://([^:/]+)(:%d+)/(.*)$', 'https://%1/%3' },
        { '^ssh://([^/]+)/(.*)$', 'https://%1/%2' },
        { 'ssh%.dev%.azure%.com/v3/(.*)/(.*)$', 'dev.azure.com/%1/_git/%2' },
        { '^https://%w*@(.*)', 'https://%1' },
        { '^git@(.*)', 'https://%1' },
        { ':%d+', '' },
        { '%.git$', '' },
      },
      url_patterns = {
        ['github%.com'] = {
          branch = '/tree/{branch}',
          file = '/blob/{branch}/{file}#L{line_start}-L{line_end}',
          permalink = '/blob/{commit}/{file}#L{line_start}-L{line_end}',
          commit = '/commit/{commit}',
        },
        ['gitlab%.com'] = {
          branch = '/-/tree/{branch}',
          file = '/-/blob/{branch}/{file}#L{line_start}-L{line_end}',
          permalink = '/-/blob/{commit}/{file}#L{line_start}-L{line_end}',
          commit = '/-/commit/{commit}',
        },
        ['bitbucket%.org'] = {
          branch = '/src/{branch}',
          file = '/src/{branch}/{file}#lines-{line_start}-L{line_end}',
          permalink = '/src/{commit}/{file}#lines-{line_start}-L{line_end}',
          commit = '/commits/{commit}',
        },
        ['git.sr.ht'] = {
          branch = '/tree/{branch}',
          file = '/tree/{branch}/item/{file}',
          permalink = '/tree/{commit}/item/{file}#L{line_start}',
          commit = '/commit/{commit}',
        },
      },
    },
    image = {
      enabled = false,
      doc = {
        -- Personally I set this to false, I don't want to render all the
        -- images in the file, only when I hover over them
        -- render the image inline in the buffer
        -- if your env doesn't support unicode placeholders, this will be disabled
        -- takes precedence over `opts.float` on supported terminals
        inline = vim.g.neovim_mode == 'skitty' and true or false,
        -- only_render_image_at_cursor = vim.g.neovim_mode == "skitty" and false or true,
        -- render the image in a floating window
        -- only used if `opts.inline` is disabled
        float = true,
        -- Sets the size of the image
        -- max_width = 60,
        max_width = vim.g.neovim_mode == 'skitty' and 20 or 60,
        max_height = vim.g.neovim_mode == 'skitty' and 10 or 30,
        -- max_height = 30,
        -- Apparently, all the images that you preview in neovim are converted
        -- to .png and they're cached, original image remains the same, but
        -- the preview you see is a png converted version of that image
        --
        -- Where are the cached images stored?
        -- This path is found in the docs
        -- :lua print(vim.fn.stdpath("cache") .. "/snacks/image")
        -- For me returns `~/.cache/neobean/snacks/image`
        -- Go 1 dir above and check `sudo du -sh ./* | sort -hr | head -n 5`
      },
    },
  },
  keys = {
    {
      '<M-g>',
      function()
        Snacks.picker.git_branches {
          layout = 'select',
        }
      end,
      desc = 'Branches',
    },
    -- Used in LazyVim to view the different keymaps, this by default is
    -- configured as <leader>sk but I run it too often
    -- Sometimes I need to see if a keymap is already taken or not
    {
      '<M-k>',
      function()
        Snacks.picker.keymaps {
          layout = 'vertical',
        }
      end,
      desc = 'Keymaps',
    },
    -- File picker
    -- {
    --   "<leader><space>",
    --   function()
    --     Snacks.picker.files({
    --       finder = "files",
    --       format = "file",
    --       show_empty = true,
    --       supports_live = true,
    --       -- In case you want to override the layout for this keymap
    --       -- layout = "vscode",
    --     })
    --   end,
    --   desc = "Find Files",
    -- },
    -- Navigate my buffers
    {
      '<S-b>',
      function()
        Snacks.picker.buffers {
          layout = 'vertical',
          -- I always want my buffers picker to start in normal mode
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
      desc = '[P]Snacks picker buffers', -- FIXME: It dosn't work
    },
  },
}
