return {
  'nvim-telescope/telescope.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
    'nvim-telescope/telescope-fzf-native.nvim',
    build = 'make',
    config = function()
      require('telescope').load_extension 'fzf'
    end,
  },
  keys = {
      -- add a keymap to browse plugin files
      -- stylua: ignore
    {
      '<leader>fp',
      function()
        require('telescope.builtin').find_files { cwd = require('lazy.core.config').options.root }
      end,
      desc = 'Find Plugin File',
    },

    {
      '<leader>gC',
      function()
        -- require("telescope.builtin").git_bcommits(require("telescope.themes").get_ivy({}))
        require('telescope.builtin').git_bcommits()
      end,
      desc = 'commits for current file ',
    },
  },

  config = function()
    local telescope = require 'telescope'
    local actions = require 'telescope.actions'
    --       local trouble = require("trouble.providers.telescope")
    --       local icons = require("config.icons")
    --
    local function formattedName(_, path)
      local tail = vim.fs.basename(path)
      local parent = vim.fs.dirname(path)
      if parent == '.' then
        return tail
      end
      return string.format('%s\t\t%s', tail, parent)
    end

    telescope.setup {

      defaults = {
        -- layout_strategy = "horizontal",
        layout_strategy = 'vertical',
        layout_config = { prompt_position = 'top', vertical = { width = 0.85 } },
        -- layout_config = {
        --   vertical = {
        --     width = 0.75,
        --   },
      },
      sorting_strategy = 'ascending',
      winblend = 0,

      pickers = {
        buffers = {
          path_display = formattedName,
          mappings = {
            i = {
              ['<c-d>'] = actions.delete_buffer,
            },
            n = {
              ['<c-d>'] = actions.delete_buffer,
            },
          },
          previewer = false,
          initial_mode = 'normal',
          -- theme = "dropdown",
          layout_config = {
            height = 0.4,
            width = 0.6,
            prompt_position = 'top',
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
    }
  end,
}
-- lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy({ winblend = 10 }))

-- pickers = {
--   find_files = {
--     theme = "ivy",
--   },
--   live_grep = {
--     theme = "ivy",
--   },
--   grep_string = {
--     theme = "ivy",
--   },
--   git_bcommits = {
--     theme = "dropdown",
--   },
-- },
-- lua require'telescope.builtin'.find_files(require('telescope.themes').get_ivy({ winblend = 10 }))

--   find_files = {
--     theme = "ivy",
--   },
--   live_grep = {
--     theme = "ivy",
--   },
--   grep_string = {
--     theme = "ivy",
--   },
--   git_bcommits = {
--     theme = "dropdown",
--   },

-- return {
--   {
--     "nvim-telescope/telescope.nvim",
--     cmd = "Telescope",
--     version = false,
--     lazy = true,
--     dependencies = {
--       "nvim-lua/plenary.nvim",
--       "nvim-tree/nvim-web-devicons",
--       { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
--       "nvim-telescope/telescope-ui-select.nvim",
--       -- "telescope-dap.nvim",
--       "kkharji/sqlite.lua",
--       "nvim-telescope/telescope-frecency.nvim",
--     },
--     keys = {
--       -- add a keymap to browse plugin files
--       -- stylua: ignore
--       {
--         "<leader>fp",
--         function() require("telescope.builtin").find_files({ cwd = require("lazy.core.config").options.root }) end,
--         desc = "Find Plugin File",
--       },
--       {
--         "<leader>gC",
--         function()
--           -- require("telescope.builtin").git_bcommits(require("telescope.themes").get_dropdown({}))
--           require("telescope.builtin").git_bcommits()
--         end,
--         desc = "commits for current file ",
--       },
--     },
--     config = function()
--       local telescope = require("telescope")
--       local actions = require("telescope.actions")
--       local trouble = require("trouble.providers.telescope")
--       local icons = require("config.icons")
--
--       vim.api.nvim_create_autocmd("FileType", {
--         pattern = "TelescopeResults",
--         callback = function(ctx)
--           vim.api.nvim_buf_call(ctx.buf, function()
--             vim.fn.matchadd("TelescopeParent", "\t\t.*$")
--             vim.api.nvim_set_hl(0, "TelescopeParent", { link = "Comment" })
--           end)
--         end,
--       })
--
--       local function formattedName(_, path)
--         local tail = vim.fs.basename(path)
--         local parent = vim.fs.dirname(path)
--         if parent == "." then
--           return tail
--         end
--         return string.format("%s\t\t%s", tail, parent)
--       end
--
--       telescope.setup({
--         file_ignore_patterns = { "%.git/." },
--         -- borderchars = { "█", " ", "▀", "█", "█", " ", " ", "▀" },
--         defaults = {
--           mappings = {
--             i = {
--               ["<esc>"] = actions.close,
--               ["<C-t>"] = trouble.open_with_trouble,
--             },
--
--             n = { ["<C-t>"] = trouble.open_with_trouble },
--           },
--           previewer = false,
--           prompt_prefix = " " .. icons.ui.Telescope .. " ",
--           selection_caret = icons.ui.BoldArrowRight .. " ",
--           file_ignore_patterns = { "node_modules", "package-lock.json" },
--           initial_mode = "insert",
--           select_strategy = "reset",
--           sorting_strategy = "ascending",
--           color_devicons = true,
--           set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
--           layout_config = {
--             prompt_position = "top",
--             preview_cutoff = 120,
--           },
--           vimgrep_arguments = {
--             "rg",
--             "--color=never",
--             "--no-heading",
--             "--with-filename",
--             "--line-number",
--             "--column",
--             "--smart-case",
--             "--hidden",
--             "--glob=!.git/",
--           },
--         },
--         pickers = {
--           find_files = {
--             previewer = false,
--             path_display = formattedName,
--             layout_config = {
--               height = 0.4,
--               prompt_position = "top",
--               preview_cutoff = 120,
--             },
--           },
--           git_files = {
--             previewer = false,
--             path_display = formattedName,
--             layout_config = {
--               height = 0.4,
--               prompt_position = "top",
--               preview_cutoff = 120,
--             },
--           },
--           buffers = {
--             path_display = formattedName,
--             mappings = {
--               i = {
--                 ["<c-d>"] = actions.delete_buffer,
--               },
--               n = {
--                 ["<c-d>"] = actions.delete_buffer,
--               },
--             },
--             previewer = false,
--             initial_mode = "normal",
--             -- theme = "dropdown",
--             layout_config = {
--               height = 0.4,
--               width = 0.6,
--               prompt_position = "top",
--               preview_cutoff = 120,
--             },
--           },
--           current_buffer_fuzzy_find = {
--             previewer = true,
--             layout_config = {
--               prompt_position = "top",
--               preview_cutoff = 120,
--             },
--           },
--           live_grep = {
--             only_sort_text = true,
--             previewer = true,
--           },
--           grep_string = {
--             only_sort_text = true,
--             previewer = true,
--             path_display = formattedName,
--             layout_config = {
--               height = 0.76,
--               prompt_position = "top",
--               preview_cutoff = 120,
--             },
--           },
--           lsp_references = {
--             show_line = false,
--             previewer = true,
--           },
--           treesitter = {
--             show_line = false,
--             previewer = true,
--           },
--           colorscheme = {
--             enable_preview = true,
--           },
--         },
--         extensions = {
--           fzf = {
--             fuzzy = true, -- false will only do exact matching
--             override_generic_sorter = true, -- override the generic sorter
--             override_file_sorter = true, -- override the file sorter
--             case_mode = "smart_case", -- or "ignore_case" or "respect_case"
--           },
--           ["ui-select"] = {
--             require("telescope.themes").get_dropdown({
--               previewer = false,
--               initial_mode = "normal",
--               sorting_strategy = "ascending",
--               layout_strategy = "horizontal",
--               layout_config = {
--                 horizontal = {
--                   width = 0.5,
--                   height = 0.4,
--                   preview_width = 0.6,
--                 },
--               },
--             }),
--           },
--           frecency = {
--             default_workspace = "CWD",
--             show_scores = true,
--             show_unindexed = true,
--             disable_devicons = false,
--             ignore_patterns = {
--               "*.git/*",
--               "*/tmp/*",
--               "*/lua-language-server/*",
--             },
--           },
--         },
--       })
--       telescope.load_extension("fzf")
--       telescope.load_extension("ui-select")
--       -- telescope.load_extension("refactoring")
--       -- telescope.load_extension("dap")
--       telescope.load_extension("frecency")
--       telescope.load_extension("notify")
--     end,
--   },
-- }
