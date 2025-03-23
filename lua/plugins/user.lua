return {
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "catppuccin",
        },
    },
    {
        "catppuccin/nvim",
        opts = {
            transparent_background = true,
        },
    },
    {
        "nvim-telescope/telescope.nvim",
        keys = {
            -- Add a keymap to browse plugin files
            -- stylua: ignore
            {
                "<leader>fp",
                function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
                desc = "Find Plugin File",
            },
        },
        -- change some options
        opts = {
            defaults = {
                layout_strategy = "horizontal",
                layout_config = { prompt_position = "bottom" },
                vertical = { width = 0.8 },
                sorting_strategy = "ascending",
                winblend = 0,
            },
            pickers = {
                find_files = {
                    theme = "ivy",
                },
            },
        },
    },
    -- { -- Neotree -- TODO: zamienic z Snacks.explore()
    --   -- Changes key mappings
    --   "nvim-neo-tree/neo-tree.nvim",
    --   keys = {
    --     -- don't use with edgy
    --     -- { "-", "<cmd>Neotree filesystem reveal float<cr>", { desc = "Reveal file in Neotree" } },
    --   },
    --   opts = function(_, opts)
    --     opts.position = "current"
    --     opts.event_handlers = {
    --       {
    --         event = "file_opened",
    --         handler = function() -- (file_path)
    --           require("neo-tree.command").execute({ action = "close" })
    --         end,
    --       },
    --     }
    --   end,
    -- },
    {
        "sindrets/diffview.nvim",
        event = "BufRead",
        dependencies = {
            "nvim-lua/plenary.nvim",
        },
        cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
        keys = {
            { "<leader>gd", "<cmd>DiffviewOpen <cr>", desc = "Open DiffviewOpen" },
            -- ["<F4>"] = { ":DiffviewClose<cr>", desc = "Close Diff View" }, -- closing Diffview
            { "<F4>",       ":DiffviewClose <cr>",    desc = "Close Diff View" }, -- closing Diffview
        },
    },

    {
        "aaronhallaert/advanced-git-search.nvim",
        dependencies = {
            "tpope/vim-rhubarb",
            "nvim-telescope/telescope.nvim",
        },
        cmd = { "AdvancedGitSearch" },
        config = function()
            require("telescope").load_extension("advanced_git_search")
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
        "akinsho/git-conflict.nvim",
        vscode = false,
        lazy = true,
        event = "LazyFile",
        opts = {},
        keys = {
            { "<leader>gxl", "<cmd>GitConflictListQf<cr>", desc = "List git conflicts" },
        },
    },
    {
        "mikavilpas/yazi.nvim",
        vscode = false,
        event = "VeryLazy",
        keys = {
            {
                "_",
                "<cmd>Yazi<cr>",
                desc = "Open yazi at the current file",
            },
            {
                "<leader>fx",
                "<cmd>Yazi cwd<cr>",
                desc = "Explore with Yazi (cwd)",
            },
        },
        opts = {
            -- if you want to open yazi instead of netrw, see below for more info
            open_for_directories = false,
            keymaps = {
                show_help = "<f1>",
            },
        },
    },
    {
        "hrsh7th/nvim-cmp",
        optional = true,
        dependencies = {
            { "petertriho/cmp-git", opts = {} },
        },
        ---@module 'cmp'
        ---@param opts cmp.ConfigSchema
        opts = function(_, opts)
            table.insert(opts.sources, { name = "git" })
        end,
    },
    {
        "stevearc/conform.nvim",
        optional = true,
        opts = {
            formatters_by_ft = {
                go = { "goimports", "gofumpt" },
            },
        },
    },

    -- Blink integration
    {
        "saghen/blink.cmp",
        optional = true,
        ---@module 'blink.cmp'
        ---@type blink.cmp.Config
        opts = {
            sources = {
                providers = {
                    path = {
                        -- Path sources triggered by "/" interfere with CopilotChat commands
                        enabled = function()
                            return vim.bo.filetype ~= "copilot-chat"
                        end,
                    },
                },
            },
        },
    },
    {
        "yasuhiroki/github-actions-yaml.vim"
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
        "echasnovski/mini.indentscope",
        version = false, -- wait till new 0.7.0 release to put it back on semver
        event = "LazyFile",
        opts = {
            -- symbol = "▏",
            symbol = "╎",
            options = {
                -- Type of scope's border: which line(s) with smaller indent to
                -- categorize as border. Can be one of: 'both', 'top', 'bottom', 'none'.
                border = "both",

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
    -- {
    --   "nvim-treesitter/nvim-treesitter",
    --   opts = { ensure_installed = { "helm" } },
    -- },
    --
    -- {
    --   "neovim/nvim-lspconfig",
    --   opts = {
    --     servers = {
    --       helm_ls = {},
    --     },
    --   },
    -- },
}
