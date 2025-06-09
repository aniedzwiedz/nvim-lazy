return {
  'ibhagwan/fzf-lua',
  -- optional for icon support
  -- dependencies = { "nvim-tree/nvim-web-devicons" },
  -- or if using mini.icons/mini.nvim
  dependencies = { 'echasnovski/mini.icons' },
  opts = {
    git = {
      split = 'belowright new', -- open in a split instead?
      files = {
        prompt = 'GitFiles-> ',
        cmd = 'git ls-files --exclude-standard',
        multiprocess = true, -- run command in a separate process
        git_icons = true, -- show git icons?
        file_icons = true, -- show file icons (true|"devicons"|"mini")?
        color_icons = true, -- colorize file|git icons
        -- force display the cwd header line regardless of your current working
        -- directory can also be used to hide the header when not wanted
        -- cwd_header = true,
      },
    },

    -- winopts = {
    --   split = "belowright new", -- open in a split instead?
    --   -- "belowright new"  : split below
    --   -- "aboveleft new"   : split above
    --   -- "belowright vnew" : split right
    --   -- "aboveleft vnew   : split left
    --   -- Only valid when using a float window
    --   -- (i.e. when 'split' is not defined, default)
    --   height = 0.85, -- window height
    --   width = 0.80, -- window width
    --   row = 0.35, -- window row position (0=top, 1=bottom)
    --   col = 0.30, -- window col position (0=left, 1=right)
    --   -- border argument passthrough to nvim_open_win()
    --   border = "rounded",
    --   -- Backdrop opacity, 0 is fully opaque, 100 is fully transparent (i.e. disabled)
    --   backdrop = 60,
    --   -- title         = "Title",
    --   -- title_pos     = "center",        -- 'left', 'center' or 'right'
    --   -- title_flags   = false,           -- uncomment to disable title flags
    --   fullscreen = false, -- start fullscreen?
    --   -- enable treesitter highlighting for the main fzf window will only have
    --   -- effect where grep like results are present, i.e. "file:line:col:text"
    --   -- due to highlight color collisions will also override `fzf_colors`
    --   -- set `fzf_colors=false` or `fzf_colors.hl=...` to override
    --   treesitter = {
    --     enabled = true,
    --     fzf_colors = { ["hl"] = "-1:reverse", ["hl+"] = "-1:reverse" },
    --   },
    --   winopts = { -- builtin previewer window options
    --     number = true,
    --     relativenumber = true,
    --     cursorline = true,
    --     cursorlineopt = "both",
    --     cursorcolumn = false,
    --     signcolumn = "no",
    --     list = false,
    --     foldenable = false,
    --     foldmethod = "manual",
    --   },
    -- },
    --

    winopts = {
      -- row = 0,
      -- col = 1,
      width = 0.80,
      height = 0.80,
      preview = {
        layout = 'vertical',
        vertical = 'up:70%',
        border = 'rounded',
      },
      previewer = { toggle_behavior = 'extend' },
      -- border = { "", "─", "", "", "", "", "", "" },
      -- preview = {
      --   layout = "horizontal",
      --   title_pos = "right",
      --   border = function(_, m)
      --     if m.type == "fzf" then
      --       return "single"
      --     else
      --       assert(m.type == "nvim" and m.name == "prev" and type(m.layout) == "string")
      --       local b = { "┌", "─", "┐", "│", "┘", "─", "└", "│" }
      --       if m.layout == "down" then
      --         b[1] = "├" -- top right
      --         b[3] = "┤" -- top left
      --       elseif m.layout == "up" then
      --         b[7] = "├" -- bottom left
      --         b[6] = "" -- remove bottom
      --         b[5] = "┤" -- bottom right
      --       elseif m.layout == "left" then
      --         b[3] = "┬" -- top right
      --         b[5] = "┴" -- bottom right
      --         b[6] = "" -- remove bottom
      --       else -- right
      --         b[1] = "┬" -- top left
      --         b[7] = "┴" -- bottom left
      --         b[6] = "" -- remove bottom
      --       end
      --       return b
      --     end
      --   end,
      -- },
      treesitter = {
        enabled = true,
        fzf_colors = { ['hl'] = '-1:reverse', ['hl+'] = '-1:reverse' },
      },
    },
    -- blines = {
    --   winopts = {
    --     row = 1,
    --     col = 0,
    --     width = 0.80,
    --     height = 0.80,
    --     preview = {
    --       layout = 'vertical',
    --       vertical = 'up:70%',
    --       border = 'rounded',
    --     },
    --   },
    --   previewer = { toggle_behavior = 'extend' },
    -- },
    -- lines = {
    --   winopts = {
    --     row = 1,
    --     col = 0,
    --     width = 0.80,
    --     height = 0.80,
    --     preview = {
    --       layout = 'vertical',
    --       vertical = 'up:65%',
    --       border = 'rounded',
    --     },
    --   },
    --   previewer = { toggle_behavior = 'extend' },
    -- },
    -- grep = {
    --   winopts = {
    --     row = 1,
    --     col = 0,
    --     width = 0.80,
    --     height = 0.80,
    --     -- height = 0.85, -- window height
    --     -- width = 0.80, -- window width
    --     -- row = 0.35, -- window row position (0=top, 1=bottom)
    --     -- col = 0.35, -- window col position (0=left, 1=right)
    --     preview = {
    --       layout = 'vertical',
    --       vertical = 'up:65%',
    --       border = 'rounded',
    --     },
    --   },
    --   previewer = { toggle_behavior = 'extend' },
    -- },
    -- grep_curbuf = {
    --   winopts = {
    --     row = 1,
    --     col = 0,
    --     width = 0.80,
    --     height = 0.80,
    --     preview = {
    --       layout = 'vertical',
    --       vertical = 'up:65%',
    --       border = 'none',
    --     },
    --   },
    --   previewer = { toggle_behavior = 'extend' },
    -- },
    -- git = {
    --   blame = {
    --     winopts = {
    --       row = 1,
    --       col = 0,
    --       width = 0.80,
    --       height = 1,
    --       preview = {
    --         layout = "vertical",
    --         vertical = "up:65%",
    --         border = "none",
    --       },
    --     },
    --   },
    -- },

    fzf_opts = {
      -- options are sent as `<left>=<right>`
      -- set to `false` to remove a flag
      -- set to `true` for a no-value flag
      -- for raw args use `fzf_args` instead
      ['--ansi'] = true,
      ['--info'] = 'inline-right', -- fzf < v0.42 = "inline"
      ['--height'] = '100%',
      ['--layout'] = 'reverse',
      -- ['--border'] = 'none',
      ['--highlight-line'] = true, -- fzf >= v0.53
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
    -- {
    --   "<leader>fs", --NOTE: chyba nie do konca o to mi chodzilo
    --   function()
    --     require("fzf-lua").lsp_document_symbols()
    --   end,
    --   desc = "Find Document Symbols",
    -- },
  },
}
