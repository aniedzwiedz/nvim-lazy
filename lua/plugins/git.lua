return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = false,
    config = function()
      local icons = require "config.icons"
      require("gitsigns").setup {
        signs = {
          add = { text = "+" },
          -- add = {
          --   hl = "GitSignsAdd",
          --   text = icons.git.LineAdded ,
          --   numhl = "GitSignsAddNr",
          --   linehl = "GitSignsAddLn",
          -- },
          change = { text = "~" },
          delete = { text = "_" },
          topdelete = { text = "‾" },
          changedelete = { text = "~" },
        },
        signcolumn = true,
        numhl = false,
        linehl = false,
        word_diff = false,
        watch_gitdir = {
          interval = 1000,
          follow_files = true,
        },
        attach_to_untracked = true,
        current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
        current_line_blame_opts = {
          virt_text = true,
          virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
          delay = 1000,
          ignore_whitespace = false,
        },
        current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
        sign_priority = 6,
        status_formatter = nil,
        update_debounce = 200,
        max_file_length = 40000,
        preview_config = {
          border = "rounded",
          style = "minimal",
          relative = "cursor",
          row = 0,
          col = 1,
        },
        yadm = { enable = false },

        on_attach = function(bufnr)
          vim.keymap.set(
            "n",
            "<leader>gH",
            require("gitsigns").preview_hunk,
            { buffer = bufnr, desc = "Preview git hunk" }
          )

          vim.keymap.set(
            "n",
            "<leader>gR",
            require("gitsigns").reset_hunk,
            { buffer = bufnr, desc = "Reset git hunk (line)" }
          )
          vim.keymap.set("n", "]]", require("gitsigns").next_hunk, { buffer = bufnr, desc = "Next git hunk" })
          vim.keymap.set("n", "[[", require("gitsigns").prev_hunk, { buffer = bufnr, desc = "Previous git hunk" })
        end,
      }
    end,
  },
  {
    "NeogitOrg/neogit",
    dependencies = {
      "nvim-lua/plenary.nvim", -- required
      "sindrets/diffview.nvim", -- optional - Diff integration

      -- Only one of these is needed, not both.
      "nvim-telescope/telescope.nvim", -- optional
      "ibhagwan/fzf-lua", -- optional
    },
    config = true,
    opts = {
      kind = "split",
      commit_editor = {
        kind = "auto",
        show_staged_diff = true,
        -- Accepted values:
        -- "split" to show the staged diff below the commit editor
        -- "vsplit" to show it to the right
        -- "split_above" Like :top split
        -- "vsplit_left" like :vsplit, but open to the left
        -- "auto" "vsplit" if window would have 80 cols, otherwise "split"
        staged_diff_split_kind = "split",
      },
      commit_select_view = {
        kind = "tab",
      },
    },
    keys = {
      { "<leader>gg", "<cmd>Neogit kind=vsplit <cr>", desc = "Open Meogit" },
      -- { "<F4>", ":DiffviewClose <cr>", desc = "Close Diff View" }, -- closing Diffview
    },
  },
  -- { "folke/neodev.nvim" },
  -- {
  --   "someone-stole-my-name/yaml-companion.nvim",
  --   dependencies = {
  --     { "neovim/nvim-lspconfig" },
  --     { "nvim-lua/plenary.nvim" },
  --     { "nvim-telescope/telescope.nvim" },
  --   },
  --   config = function()
  --     require("telescope").load_extension("yaml_schema")
  --   end,
  -- },

  {
    "linrongbin16/gitlinker.nvim",
    event = "BufRead",
    dependencies = { { "nvim-lua/plenary.nvim" } },
    config = function()
      local wk = require "which-key"
      wk.register {
        ["<leader>gy"] = { "<cmd>GitLink<cr>", "Git link" },
        ["<leader>gY"] = { "<cmd>GitLink blame<cr>", "Git link blame" },
      }

      require("gitlinker").setup {
        message = true,
        -- mapping = {
        --   ["<leader>gY"] = {
        --     -- copy git link to clipboard
        --     action = require("gitlinker.actions").clipboard,
        --     desc = "Copy git link to clipboard",
        --   },
        --   ["<leader>gy"] = {
        --     -- open git link in browser
        --     action = require("gitlinker.actions").system,
        --     desc = "Open git link in browser",
        --   },
        -- },

        -- remote = 'github', -- force the use of a specific remote
        router = {
          browse = {
            ["^git.gtech.com"] = "https://git.gtech.com/projects/"
              .. "{_A.ORG}/"
              .. "repos/{_A.REPO}/"
              -- .. "{_A.REV}/"
              .. "browse/{_A.FILE}"
              .. "?at=refs/heads/{_A.CURRENT_BRANCH}"
              .. "#{_A.LSTART}"
              -- .. "{_A.LEND > _A.LSTART and ('&lines-count=' .. _A.LEND - _A.LSTART + 1) or ''}",
              .. "{(_A.LEND > _A.LSTART and (':' .. _A.LEND) or '')}",
          },
        },
      }
    end,
  },
  {
    "sindrets/diffview.nvim",
    event = "BufRead",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
    keys = {
      { "<leader>gD", "<cmd>DiffviewOpen <cr>", desc = "Open DiffviewOpen" },
      -- ["<F4>"] = { ":DiffviewClose<cr>", desc = "Close Diff View" }, -- closing Diffview
      { "<F4>", ":DiffviewClose <cr>", desc = "Close Diff View" }, -- closing Diffview
    },
  },

  "petertriho/cmp-git",

  config = function()
    local format = require "cmp_git.format"
    local sort = require "cmp_git.sort"

    require("cmp_git").setup {
      -- defaults
      filetypes = { "gitcommit", "octo", "NeogitCommitMessage" },
      remotes = { "upstream", "origin" }, -- in order of most to least prioritized
      enableRemoteUrlRewrites = false, -- enable git url rewrites, see https://git-scm.com/docs/git-config#Documentation/git-config.txt-urlltbasegtinsteadOf
      git = {
        commits = {
          limit = 100,
          sort_by = sort.git.commits,
          format = format.git.commits,
        },
      },
      github = {
        hosts = {}, -- list of private instances of github
        issues = {
          fields = { "title", "number", "body", "updatedAt", "state" },
          filter = "all", -- assigned, created, mentioned, subscribed, all, repos
          limit = 100,
          state = "open", -- open, closed, all
          sort_by = sort.github.issues,
          format = format.github.issues,
        },
        mentions = {
          limit = 100,
          sort_by = sort.github.mentions,
          format = format.github.mentions,
        },
        pull_requests = {
          fields = { "title", "number", "body", "updatedAt", "state" },
          limit = 100,
          state = "open", -- open, closed, merged, all
          sort_by = sort.github.pull_requests,
          format = format.github.pull_requests,
        },
      },
      gitlab = {
        hosts = {}, -- list of private instances of gitlab
        issues = {
          limit = 100,
          state = "opened", -- opened, closed, all
          sort_by = sort.gitlab.issues,
          format = format.gitlab.issues,
        },
        mentions = {
          limit = 100,
          sort_by = sort.gitlab.mentions,
          format = format.gitlab.mentions,
        },
        merge_requests = {
          limit = 100,
          state = "opened", -- opened, closed, locked, merged
          sort_by = sort.gitlab.merge_requests,
          format = format.gitlab.merge_requests,
        },
      },
      trigger_actions = {
        {
          debug_name = "git_commits",
          trigger_character = ":",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.git:get_commits(callback, params, trigger_char)
          end,
        },
        {
          debug_name = "gitlab_issues",
          trigger_character = "#",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.gitlab:get_issues(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = "gitlab_mentions",
          trigger_character = "@",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.gitlab:get_mentions(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = "gitlab_mrs",
          trigger_character = "!",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.gitlab:get_merge_requests(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = "github_issues_and_pr",
          trigger_character = "#",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.github:get_issues_and_prs(callback, git_info, trigger_char)
          end,
        },
        {
          debug_name = "github_mentions",
          trigger_character = "@",
          action = function(sources, trigger_char, callback, params, git_info)
            return sources.github:get_mentions(callback, git_info, trigger_char)
          end,
        },
      },
    }
  end,
}
