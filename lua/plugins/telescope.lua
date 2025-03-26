if true then return {} end -- NOTE disabled for now

return {
    {
        "nvim-telescope/telescope.nvim",
        dependencies = {
            "nvim-telescope/telescope-frecency.nvim",
            "nvim-lua/plenary.nvim",
            "nvim-tree/nvim-web-devicons",
            "nvim-telescope/telescope-fzf-native.nvim",
            "nvim-telescope/telescope-github.nvim",
            build = "make",
        },
        keys = {
            -- add a keymap to browse plugin files
            -- stylua: ignore
            {
                "<leader>fP",
                function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
                desc = "Find Plugin File",
            },
            {
                "<leader>s'",
                function() require("telescope.builtin").marks() end,
                desc = "Find marks"
            },
            {
                "<leader>sW",
                function()
                    require("telescope.builtin").live_grep {
                        additional_args = function(args) return vim.list_extend(args, { "--hidden", "--no-ignore" }) end,
                    }
                end,
                desc = "Find words in all files",
            },
            {
                "<leader>s/",
                function() require("telescope.builtin").current_buffer_fuzzy_find() end,
                desc = "Find words in current buffer",
            },
            {
                "<leader>ff",
                "<cmd>Telescope frecency workspace=CWD theme=ivy<cr>",
                desc = "Find Files (frecency)",
            },
            { "<leader>gC", "<cmd>AdvancedGitSearch diff_commit_file<cr>", desc = "Commits for [C]urrent file" },
            {
                "<leader>gW",
                function()
                    local function is_git_repo()
                        vim.fn.system("git rev-parse --is-inside-work-tree")

                        return vim.v.shell_error == 0
                    end

                    local function get_git_root()
                        local dot_git_path = vim.fn.finddir(".git", ".;")
                        return vim.fn.fnamemodify(dot_git_path, ":h")
                    end

                    local opts = {}

                    if is_git_repo() then
                        opts = {
                            cwd = get_git_root(),
                        }
                    end

                    require("telescope.builtin").live_grep(opts)
                end,
                desc = "Live grep from project git root with fallback",
            },
            {
                "<leader>gF",
                function()
                    local function is_git_repo()
                        vim.fn.system("git rev-parse --is-inside-work-tree")
                        return vim.v.shell_error == 0
                    end
                    local function get_git_root()
                        local dot_git_path = vim.fn.finddir(".git", ".;")
                        return vim.fn.fnamemodify(dot_git_path, ":h")
                    end
                    local opts = {}
                    if is_git_repo() then
                        opts = {
                            cwd = get_git_root(),
                        }
                    end
                    require("telescope.builtin").find_files(opts)
                end,


                desc = "Find files from project git root with fallback",
            }
        },

        config = function(_, opts)
            require("telescope").load_extension("frecency")
            -- require("telescope").load_extension("fzf")
            local telescope = require("telescope")
            local actions = require("telescope.actions")
            --       local trouble = require("trouble.providers.telescope")
            --       local icons = require("config.icons")
            --
            local function formattedName(_, path)
                local tail = vim.fs.basename(path)
                local parent = vim.fs.dirname(path)
                if parent == "." then
                    return tail
                end
                return string.format("%s\t\t%s", tail, parent)
            end

            telescope.setup({

                defaults = {
                    file_ignore_patterns = { "^%.git[/\\]", "[/\\]%.git[/\\]" },
                    git_worktrees = {
                        sessions = {
                            autosave = { last = true, cwd = true },
                            ignore = {
                                dirs = {},
                                filetypes = { "gitcommit", "gitrebase" },
                                buftypes = {},
                            },
                        },

                    },
                    hidden = false,
                    path_display = { "truncate" },
                    layout_config = {
                        horizontal = { prompt_position = "bottom", preview_width = 0.55 },
                        vertical = { mirror = false },
                        width = 0.87,
                        height = 0.80,
                        preview_cutoff = 120,
                    },
                    preview = {
                        mime_hook = function(filepath, bufnr, opts)
                            local is_image = function(filepath)
                                local image_extensions = { 'png', 'jpg' } -- Supported image formats
                                local split_path = vim.split(filepath:lower(), '.', { plain = true })
                                local extension = split_path[#split_path]
                                return vim.tbl_contains(image_extensions, extension)
                            end
                            if is_image(filepath) then
                                local term = vim.api.nvim_open_term(bufnr, {})
                                local function send_output(_, data, _)
                                    for _, d in ipairs(data) do
                                        vim.api.nvim_chan_send(term, d .. '\r\n')
                                    end
                                end
                                vim.fn.jobstart(
                                    {
                                        'catimg', filepath -- Terminal image viewer command
                                    },
                                    { on_stdout = send_output, stdout_buffered = true, pty = true })
                            else
                                require("telescope.previewers.utils").set_preview_message(bufnr, opts.winid,
                                    "Binary cannot be previewed")
                            end
                        end
                    },

                },
                sorting_strategy = "ascending",
                winblend = 0,

                vimgrep_arguments = {
                    "rg",
                    "--no-heading",
                    "--with-filename",
                    "--line-number",
                    "--column",
                    "--smart-case",
                    "--trim" -- add this value
                },
                pickers = {

                    find_files = {
                        -- hidden = true,
                        find_command = { "fd", "--type", "f", "--strip-cwd-prefix" },
                        -- find_command = {
                        --   "rg",
                        --   "--files",
                        --   "--hidden",
                        --   "--line-number",
                        --   "-g",
                        --   "!{**/.git/*,**/node_modules/*,**/package-lock.json,**/yarn.lock}",
                        -- },
                        layout_config = {
                            -- height = 0.70,
                        },
                    },
                    live_grep = {
                        additional_args = { "--hidden" },
                    },
                    grep_string = {
                        additional_args = { "--hidden" },
                    },

                    -- git_status = {
                    --   git_icons = {
                    --     added = " ",
                    --     changed = " ",
                    --     copied = " ",
                    --     deleted = " ",
                    --     renamed = "➡",
                    --     unmerged = " ",
                    --     untracked = " ",
                    --   },
                    -- },

                    extensions = {
                        gh = {},
                        advanced_git_search = {
                            diff_plugin = "diffview",
                        },
                        frecency = {
                            show_scores = true, -- Default: false
                            -- If `true`, it shows confirmation dialog before any entries are removed from the DB
                            -- If you want not to be bothered with such things and to remove stale results silently
                            -- set db_safe_mode=false and auto_validate=true
                            --
                            -- This fixes an issue I had in which I couldn't close the floating
                            -- window because I couldn't focus it
                            db_safe_mode = false,       -- Default: true
                            -- If `true`, it removes stale entries count over than db_validate_threshold
                            auto_validate = true,       -- Default: true
                            -- It will remove entries when stale ones exist more than this count
                            db_validate_threshold = 10, -- Default: 10
                            -- Show the path of the active filter before file paths.
                            -- So if I'm in the `dotfiles-latest` directory it will show me that
                            -- before the name of the file
                            show_filter_column = false, -- Default: true
                            -- I declare a workspace which I will use when calling frecency if I
                            -- want to search for files in a specific path
                            -- workspaces = {
                            --   ["neobean_plugins"] = "$HOME/.config/LazyVim/",
                            -- },
                        },

                    },
                    buffers = {
                        path_display = formattedName,
                        mappings = {
                            i = {
                                ["<c-d>"] = actions.delete_buffer,
                            },
                            n = {
                                ["<c-d>"] = actions.delete_buffer,
                            },
                        },
                        previewer = false,
                        initial_mode = "normal",
                        -- theme = "ivy",
                        layout_config = {
                            height = 0.4,
                            width = 0.6,
                            prompt_position = "top",
                            preview_cutoff = 120,
                        },
                        lsp_references = {
                            show_line = false,
                            previewer = true,
                        },
                        treesitter = {
                            show_line = false,
                            previewer = true,
                        },
                        colorscheme = {
                            enable_preview = true,
                        },
                    },
                },
            })
        end,
    },
}
