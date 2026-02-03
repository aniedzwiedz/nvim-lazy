return {
  {
    'LazyVim/LazyVim',
    opts = {
      colorscheme = 'catppuccin',
    },
  },
  {
    'stevearc/quicker.nvim',
    ft = 'qf',
    ---@module "quicker"
    ---@type quicker.SetupOptions
    opts = {
      buflisted = false,
      number = false,
      relativenumber = false,
      signcolumn = 'auto',
      winfixheight = true,
      wrap = false,
    },
    -- Callback function to run any custom logic or keymaps for the quickfix buffer
    on_qf = function(bufnr) end,
    edit = {
      -- Enable editing the quickfix like a normal buffer
      enabled = true,
      -- Set to true to write buffers after applying edits.
      -- Set to "unmodified" to only write unmodified buffers.
      autosave = 'unmodified',
    },
    -- Keep the cursor to the right of the filename and lnum columns
    constrain_cursor = true,
    highlight = {
      -- Use treesitter highlighting
      treesitter = true,
      -- Use LSP semantic token highlighting
      lsp = true,
      -- Load the referenced buffers to apply more accurate highlights (may be slow)
      load_buffers = false,
    },
    follow = {
      -- When quickfix window is open, scroll to closest item to the cursor
      enabled = false,
    },
    -- Map of quickfix item type to icon
    type_icons = {
      E = '󰅚 ',
      W = '󰀪 ',
      I = ' ',
      N = ' ',
      H = ' ',
    },
    -- Border characters
    borders = {
      vert = '┃',
      -- Strong headers separate results from different files
      strong_header = '━',
      strong_cross = '╋',
      strong_end = '┫',
      -- Soft headers separate results within the same file
      soft_header = '╌',
      soft_cross = '╂',
      soft_end = '┨',
    },
  },
  {
    'nvim-telescope/telescope.nvim',
    keys = {
            -- Add a keymap to browse plugin files
            -- stylua: ignore
            {
                "<leader>fp",
                function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root, hidden = true }) end,
                desc = "Find Plugin File",
            },
            {
                "<leader>gd",
                function()
                    vim.cmd('DiffviewFileHistory %')
                end,
                desc = "File history (Diffview)",
            },
    },
    -- change some options
    opts = {
      defaults = {
        layout_strategy = 'horizontal',
        layout_config = { prompt_position = 'bottom' },
        vertical = { width = 0.8 },
        sorting_strategy = 'ascending',
        winblend = 0,
      },
      pickers = {
        find_files = {
          theme = 'ivy',
          hidden = true,
        },
      },
    },
  },
  {
    'lewis6991/gitsigns.nvim',
    enabled = true,
    event = 'LazyFile',
    opts = {
      signs = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
        untracked = { text = '▎' },
      },
      signs_staged = {
        add = { text = '▎' },
        change = { text = '▎' },
        delete = { text = '' },
        topdelete = { text = '' },
        changedelete = { text = '▎' },
      },
      on_attach = function(buffer)
        local gs = package.loaded.gitsigns

        local function map(mode, l, r, desc)
          vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
        end

      -- stylua: ignore start
      map("n", "]h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "]c", bang = true })
        else
          gs.nav_hunk("next")
        end
      end, "Next Hunk")
      map("n", "[h", function()
        if vim.wo.diff then
          vim.cmd.normal({ "[c", bang = true })
        else
          gs.nav_hunk("prev")
        end
      end, "Prev Hunk")
      map("n", "]H", function() gs.nav_hunk("last") end, "Last Hunk")
      map("n", "[H", function() gs.nav_hunk("first") end, "First Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghp", gs.preview_hunk_inline, "Preview Hunk Inline")
      map("n", "<leader>ghS", function() gs.nav_hunk("next") end, "Next Hunk")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghB", function() gs.blame() end, "Blame Buffer")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
      end,
    },
  },
  {
    'nvim-neo-tree/neo-tree.nvim',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'nvim-mini/mini.icons',
      -- "nvim-tree/nvim-web-devicons",
      'MunifTanjim/nui.nvim',
    },
    event = 'VeryLazy',
    keys = {
      {
        '<leader>e',
        ':Neotree toggle right<CR>',
        silent = true,
        desc = 'File Explorer',
      },
      -- { "<leader><tab>", ":Neotree toggle left<CR>",  silent = true, desc = "Left File Explorer" },
    },
    config = function(_, opts)
      local function on_move(data)
        Snacks.rename.on_rename_file(data.source, data.destination)
      end
      local events = require 'neo-tree.events'
      opts.event_handlers = opts.event_handlers or {}
      vim.list_extend(opts.event_handlers, {
        { event = events.FILE_MOVED, handler = on_move },
        { event = events.FILE_RENAMED, handler = on_move },
      })

      local function open_grug_far(prefills)
        local grug_far = require 'grug-far'

        if not grug_far.has_instance 'explorer' then
          grug_far.open { instanceName = 'explorer' }
        else
          grug_far.get_instance('explorer'):open()
        end
        -- doing it seperately because multiple paths doesn't open work when passed with open
        -- updating the prefills without clearing the search and other fields
        grug_far.get_instance('explorer'):update_input_values(prefills, false)
      end

      local icons = require('lazyvim.config').icons

      -- NOTE: telemetry to none
      require('copilot').setup {
        server_opts_overrides = {
          settings = {
            telemetry = {
              telemetryLevel = 'none',
            },
          },
        },
      }

      require('neo-tree').setup {

        commands = {
          -- create a new neo-tree command
          grug_far_replace = function(state)
            local node = state.tree:get_node()
            local prefills = {
              -- also escape the paths if space is there
              -- if you want files to be selected, use ':p' only, see filename-modifiers
              paths = node.type == 'directory'
                  and vim.fn.fnameescape(
                    vim.fn.fnamemodify(node:get_id(), ':p')
                  )
                or vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ':h')),
            }
            open_grug_far(prefills)
          end,
          -- https://github.com/nvim-neo-tree/neo-tree.nvim/blob/fbb631e818f48591d0c3a590817003d36d0de691/doc/neo-tree.txt#L535
          -- grug_far_replace_visual = function(state, selected_nodes, callback)
          --   local paths = {}
          --   for _, node in pairs(selected_nodes) do
          --     -- also escape the paths if space is there
          --     -- if you want files to be selected, use ':p' only, see filename-modifiers
          --     local path = node.type == 'directory'
          --         and vim.fn.fnameescape(
          --           vim.fn.fnamemodify(node:get_id(), ':p')
          --         )
          --       or vim.fn.fnameescape(vim.fn.fnamemodify(node:get_id(), ':h'))
          --     table.insert(paths, path)
          --   end
          --   local prefills = { paths = table.concat(paths, '\n') }
          --   open_grug_far(prefills)
          -- end,
        },

        close_if_last_window = true,
        sources = {
          'filesystem',
          'buffers',
          'git_status',
          -- "diagnostics",
          'document_symbols',
        },

        source_selector = {
          sources = { -- table
            {
              source = 'filesystem', -- string
              display_name = ' 󰉓 Files ', -- string | nil
            },
            {
              source = 'buffers', -- string
              display_name = ' 󰈚 Buffers ', -- string | nil
            },
            {
              source = 'git_status', -- string
              display_name = ' 󰊢 Git ', -- string | nil
            },
          },
        },

        popup_border_style = 'single',
        enable_git_status = true,
        enable_modified_markers = true,
        enable_diagnostics = true,
        sort_case_insensitive = true,
        default_component_configs = {
          indent = {
            with_markers = true,
            with_expanders = true,
          },
          modified = {
            symbol = ' ',
            highlight = 'NeoTreeModified',
          },
          icon = {
            folder_closed = '',
            folder_open = '',
            folder_empty = '',
            folder_empty_open = '',
          },
          git_status = {
            symbols = {
              -- Change type
              -- added = "",
              added = icons.git.added,
              deleted = icons.git.removed,
              modified = icons.git.modified,
              renamed = '',
              -- Status type
              untracked = '',
              ignored = '',
              unstaged = '',
              staged = '',
              conflict = '',
            },
          },
          -- If you don't want to use these columns, you can set `enabled = false` for each of them individually
          file_size = {
            enabled = true,
            required_width = 64, -- min width of window required to show this column
          },
          type = {
            enabled = true,
            required_width = 122, -- min width of window required to show this column
          },
          last_modified = {
            enabled = true,
            required_width = 88, -- min width of window required to show this column
          },
          created = {
            enabled = true,
            required_width = 110, -- min width of window required to show this column
          },
          symlink_target = {
            enabled = false,
          },
        },
        window = {
          position = 'float',
          mappings = {
            -- map our new command to z
            z = 'grug_far_replace',
          },
          width = 35,
        },
        filesystem = {
          use_libuv_file_watcher = true,
          filtered_items = {
            hide_dotfiles = false,
            hide_gitignored = false,
            hide_by_name = {
              'node_modules',
            },
            never_show = {
              '.DS_Store',
              'thumbs.db',
            },
            always_show = {
              '.env',
            },
          },
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
          group_empty_dirs = false, -- when true, empty folders will be grouped together
        },
        buffers = {
          follow_current_file = {
            enabled = true, -- This will find and focus the file in the active buffer every time
            --              -- the current file is changed while the tree is open.
            leave_dirs_open = false, -- `false` closes auto expanded dirs, such as with `:Neotree reveal`
          },
        },
        -- event_handlers = {
        --   {
        --     event = "neo_tree_window_after_open",
        --     handler = function(args)
        --       if args.position == "left" or args.position == "right" then
        --         vim.cmd("wincmd =")
        --       end
        --     end,
        --   },
        --   {
        --     event = "neo_tree_window_after_close",
        --     handler = function(args)
        --       if args.position == "left" or args.position == "right" then
        --         vim.cmd("wincmd =")
        --       end
        --     end,
        --   },
        -- },
      }
    end,
  },
  {
    'sindrets/diffview.nvim',
    event = 'BufRead',
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    cmd = {
      'DiffviewOpen',
      'DiffviewClose',
      'DiffviewToggleFiles',
      'DiffviewFocusFiles',
    },
    keys = {
      { '<leader>gD', '<cmd>DiffviewOpen <cr>', desc = 'Open DiffviewOpen' },
      -- ["<F4>"] = { ":DiffviewClose<cr>", desc = "Close Diff View" }, -- closing Diffview
      { '<F4>', ':DiffviewClose <cr>', desc = 'Close Diff View' }, -- closing Diffview
    },
  },
  { -- git linker
    'ruifm/gitlinker.nvim',
    vscode = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
    },
    lazy = true,
    opts = {},
    keys = {
      { '<leader>gy', desc = 'Copy GitHub URL', mode = { 'n', 'v' } },
    },
  },

  {
    'aaronhallaert/advanced-git-search.nvim',
    dependencies = {
      'tpope/vim-rhubarb',
      'nvim-telescope/telescope.nvim',
    },
    cmd = { 'AdvancedGitSearch' },
    config = function()
      require('telescope').load_extension 'advanced_git_search'
    end,
  },
  -- {
  --     "NeogitOrg/neogit",
  --     dependencies = {
  --         "nvim-lua/plenary.nvim",  -- required
  --         "sindrets/diffview.nvim", -- optional - Diff integration
  --
  --         -- Only one of these is needed, not both.
  --         -- "nvim-telescope/telescope.nvim", -- optional
  --         'ibhagwan/fzf-lua', -- optional
  --     },
  --     config = function()
  --         local neogit = require("neogit")
  --         neogit.setup({
  --             sort_branches = "-committerdate",
  --             kind = "split",
  --             commit_editor = {
  --                 -- kind = 'split_above',
  --                 kind = "replace",
  --                 show_staged_diff = false,
  --                 -- Accepted values:
  --                 -- "split" to show the staged diff below the commit editor
  --                 -- "vsplit" to show it to the right
  --                 -- "split_above" Like :top split
  --                 -- "vsplit_left" like :vsplit, but open to the left
  --                 -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
  --                 staged_diff_split_kind = "split",
  --             },
  --             --@diagnostic disable-next-line: missing-fields
  --             commit_view = {
  --                 kind = "tab",
  --                 verify_commit = vim.fn.executable("gpg") == 1, -- Can be set to true or false, otherwise we try to find the binary
  --             },
  --             -- signs = {
  --             -- { CLOSED, OPENED }
  --             -- section = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
  --             -- item = { icons.ui.ChevronRight, icons.ui.ChevronShortDown },
  --             -- hunk = { "", "" },
  --             -- },
  --         })
  --     end,
  --
  --     keys = {
  --         { "<leader>gg", "<cmd>Neogit kind=vsplit <cr>", desc = "Open Meogit" },
  --         -- { "<F4>", ":DiffviewClose <cr>", desc = "Close Diff View" }, -- closing Diffview
  --     },
  -- },
  {
    'akinsho/git-conflict.nvim',
    vscode = false,
    lazy = true,
    event = 'LazyFile',
    opts = {},
    keys = {
      {
        '<leader>gxl',
        '<cmd>GitConflictListQf<cr>',
        desc = 'List git conflicts',
      },
    },
  },
  {
    'mikavilpas/yazi.nvim',
    vscode = false,
    event = 'VeryLazy',
    keys = {
      {
        '_',
        '<cmd>Yazi<cr>',
        desc = 'Open yazi at the current file',
      },
      {
        '<leader>fx',
        '<cmd>Yazi cwd<cr>',
        desc = 'Explore with Yazi (cwd)',
      },
    },
    opts = {
      -- if you want to open yazi instead of netrw, see below for more info
      open_for_directories = false,
      keymaps = {
        show_help = '<f1>',
      },
    },
  },
  {
    'hrsh7th/nvim-cmp',
    optional = true,
    dependencies = {
      { 'petertriho/cmp-git', opts = {} },
    },
    ---@module 'cmp'
    ---@param opts cmp.ConfigSchema
    opts = function(_, opts)
      table.insert(opts.sources, { name = 'git' })
    end,
  },

  -- add blink.compat to dependencies, https://www.lazyvim.org/extras/coding/blink#blinkcmp
  {
    'saghen/blink.compat',
    optional = true, -- make optional so it's only enabled if any extras need it
    opts = {},
    version = not vim.g.lazyvim_blink_main and '*',
  },
  -- Blink integration
  {
    'saghen/blink.cmp',
    optional = true,
    ---@module 'blink.cmp'
    ---@type blink.cmp.Config
    opts = {
      -- (Default) Only show the documentation popup when manually triggered
      completion = { documentation = { auto_show = true } },
      signature = { enabled = true },
      appearance = {
        -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
        -- Adjusts spacing to ensure icons are aligned
        nerd_font_variant = 'normal',
      },
      sources = {
        providers = {
          path = {
            -- Path sources triggered by "/" interfere with CopilotChat commands
            enabled = function()
              return vim.bo.filetype ~= 'copilot-chat'
            end,
          },
        },
      },
      -- (Default) Rust fuzzy matcher for typo resistance and significantly better performance
      -- You may use a lua implementation instead by using `implementation = "lua"` or fallback to the lua implementation,
      -- when the Rust fuzzy matcher is not available, by using `implementation = "prefer_rust"`
      --
      -- See the fuzzy documentation for more information
      fuzzy = { implementation = 'prefer_rust_with_warning' },
    },
  },
  {
    'yasuhiroki/github-actions-yaml.vim',
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "LazyFile",
  --   opts = function()
  --     Snacks.toggle({
  --       name = "Indention Guides",
  --       get = function()
  --         return require("ibl.config").get_config(0).enabled
  --       end,
  --       set = function(state)
  --         require("ibl").setup_buffer(0, { enabled = state })
  --       end,
  --     }):map("<leader>ug")
  --
  --     return {
  --       indent = {
  --         char = "┆", -- Custom character for indentation
  --         tab_char = "┆", -- Custom character for tab indentation
  --       },
  --       scope = { show_start = true, show_end = true }, -- Show start and end of scope
  --       exclude = {
  --         filetypes = {
  --           "Trouble",
  --           "alpha",
  --           "dashboard",
  --           "help",
  --           "lazy",
  --           "mason",
  --           "neo-tree",
  --           "notify",
  --           "snacks_dashboard",
  --           "Outline",
  --           "snacks_notif",
  --           "snacks_terminal",
  --           "snacks_win",
  --           "toggleterm",
  --           "trouble",
  --           "markdown", -- Added markdown to excluded filetypes
  --         },
  --       },
  --     }
  --   end,
  --   main = "ibl",
  -- }
  -- NOTE: OK
  {
    'nvim-mini/mini.indentscope',
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = 'LazyFile',
    opts = {
      -- symbol = "▏",
      symbol = '╎',
      options = {
        -- Type of scope's border: which line(s) with smaller indent to
        -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
        border = 'both',

        -- Whether to use cursor column when computing reference indent.
        -- Useful to see incremental scopes with horizontal cursor movements.
        indent_at_cursor = true,

        -- Maximum number of lines above or below within which scope is computed
        n_lines = 10000,

        -- Whether to first check input line to be a border of adjacent scope.
        -- Use it if you want to place cursor on function header to get scope of
        -- its body.
        try_as_border = false,
      },
    },
  },

  {
    'vuki656/package-info.nvim',
    ft = 'json',
    dependencies = { 'MunifTanjim/nui.nvim' },
    config = function()
      require('package-info').setup {
        autostart = false,
        package_manager = 'npm',
        colors = {
          outdated = '#db4b4b',
        },
        hide_up_to_date = true,
      }
    end,
  },
  {
    'folke/trouble.nvim',
    optional = true,
    keys = {
      { '<leader>cs', false },
    },
  },
  {
    'hedyhli/outline.nvim',
    lazy = true,
    cmd = { 'Outline', 'OutlineOpen' },
    keys = { -- Example mapping to toggle outline
      { '<leader>cs', '<cmd>Outline<CR>', desc = 'Toggle outline' },
    },
    opts = {
      symbols = {
        icon_fetcher = function(kind, bufnr, symbol)
          local access_icons =
            { public = '○', protected = '◉', private = '●' }
          local icon = require('outline.config').o.symbols.icons[kind].icon
          -- ctags provider might add an `access` key
          if symbol and symbol.access then
            return icon .. ' ' .. access_icons[symbol.access]
          end
          return icon
        end,
      },
      preview_window = {
        winhl = 'NormalFloat:',
      },
    },
  },
  {
    'nvim-lualine/lualine.nvim',
    event = 'VeryLazy',
    opts = function(_, opts)
      table.insert(opts.sections.lualine_x, 1, {
        function()
          local clients = vim.lsp.get_active_clients { bufnr = 0 }
          local linters = {}

          -- Get active linters for current buffer
          local lint_ok, lint = pcall(require, 'lint')
          if lint_ok and lint.linters_by_ft then
            local ft = vim.bo.filetype
            if lint.linters_by_ft[ft] then
              linters = lint.linters_by_ft[ft]
            end
          end

          local parts = {}

          if #clients > 0 then
            local client_names = {}
            for _, client in ipairs(clients) do
              table.insert(client_names, client.name)
            end
            table.insert(parts, 'LSP: ' .. table.concat(client_names, ', '))
          end

          if #linters > 0 then
            table.insert(parts, 'Lint: ' .. table.concat(linters, ', '))
          end

          return table.concat(parts, ' | ')
        end,
        color = { fg = '#808080' },
      })
      -- table.insert(opts.sections.lualine_x, {
      --   function()
      --     return "😄"
      --   end,
      -- })
    end,
  },
  -- -- https://github.com/LazyVim/LazyVim/pull/5335/files
  -- recommended = function()
  --   return LazyVim.extras.wants({
  --     ft = "helm",
  --     root = "Chart.yaml",
  --   })
  -- end,
  --
  -- { "qvalentin/helm-ls.nvim", ft = "helm" },
  --
  {
    'nvim-treesitter/nvim-treesitter',
    opts = { ensure_installed = { 'helm' } },
  },
  --
  { -- lua require('grug-far').open({ prefills = { search = vim.fn.expand("<cword>") } })
    'MagicDuck/grug-far.nvim',
    opts = { headerMaxWidth = 80 },
    cmd = 'GrugFar',
    keys = {
      {
        '<leader>sr',
        function()
          local grug = require 'grug-far'
          local ext = vim.bo.buftype == '' and vim.fn.expand '%:e'
          grug.open {
            transient = true,
            prefills = {
              filesFilter = ext and ext ~= '' and '*.' .. ext or nil,
              extraArgs = { '--hidden', '--smart-case' },
              search = vim.fn.expand '<cword>',
            },
          }
        end,
        mode = { 'n', 'v' },
        desc = 'Search and Replace (grug-far)',
      },
    },
  },

  -- {
  --   'neovim/nvim-lspconfig',
  --   opts = {
  --     servers = {
  --       helm_ls = {},
  --       neocmake = {},
  --       azure_pipelines_ls = {
  --         settings = {
  --           yaml = {
  --             schemas = {
  --               ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] = {
  --                 '/azure-pipeline*.y*l',
  --                 '/*.azure*',
  --                 'Azure-Pipelines/**/*.y*l',
  --                 'Pipelines/*.y*l',
  --                 './auredevops/**/*.{yml,yaml}',
  --                 './auredevops/non-production/install/*.{yml,yaml}',
  --               },
  --             },
  --           },
  --         },
  --       },
  --
  --       yamlls = {
  --         settings = {
  --           yaml = {
  --             schemas = {
  --               -- GitHub Actions schema
  --               ['https://json.schemastore.org/github-workflow.json'] = '.github/workflows/*',
  --               -- Azure Pipelines schema
  --               -- ['https://raw.githubusercontent.com/microsoft/azure-pipelines-vscode/master/service-schema.json'] = '.azuredevops/**/*.{yml,yaml}',
  --             },
  --             -- Optional: disable built-in schema store if you want full control
  --             -- schemaStore = {
  --             --   enable = false,
  --             --   url = '',
  --             -- },
  --             validate = true,
  --             format = {
  --               enable = true,
  --             },
  --             hover = true,
  --             completion = true,
  --           },
  --         },
  --       },
  --     },
  --   },
  -- },
}
