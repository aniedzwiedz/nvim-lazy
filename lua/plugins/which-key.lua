return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  opts = {
    plugins = {
      spelling = {
        enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
        suggestions = 20, -- how many suggestions should be shown in the list?
      },
    },
    defaults = {
      mode = { "n", "v" },
      -- ["g"] = { name = "+goto" },
      -- ["gs"] = { name = "+surround" },
      -- ["]"] = { name = "+next" },
      -- ["["] = { name = "+prev" },
      -- ["<leader><tab>"] = { name = "+tabs" },
      -- ["<leader>b"] = { name = "+buffer" },
      -- ["<leader>c"] = { name = "+code" },
      -- ["<leader>f"] = { name = "+file/find" },
      -- ["<leader>g"] = { name = "+git" },
      -- ["<leader>gh"] = { name = "+hunks" },
      -- ["<leader>q"] = { name = "+quit/session" },
      -- ["<leader>t"] = { name = "+test" },
      -- ["<leader>u"] = { name = "+ui" },
      -- ["<leader>w"] = { name = "+windows" },
      -- ["<leader>x"] = { name = "+diagnostics/quickfix" },
    },
    icons = {
      breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
      separator = "➜", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    window = {
      border = "none", -- none, single, double, shadow
      position = "bottom", -- bottom, top
      margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]. When between 0 and 1, will be treated as a percentage of the screen size.
      padding = { 1, 2, 1, 2 }, -- extra window padding [top, right, bottom, left]
      winblend = 10, -- value between 0-100 0 for fully opaque and 100 for fully transparent
      zindex = 1000, -- positive value to position WhichKey above other floating windows.
    },
    layout = {
      height = { min = 5, max = 10 }, -- min and max height of the columns
      width = { min = 10, max = 40 }, -- min and max width of the columns
      spacing = 5, -- spacing between columns
      align = "left", -- align columns left, center or right
    },
    ignore_missing = false, -- enable this to hide mappings for which you didn't specify a label
    hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "^:", "^ ", "^call ", "^lua " }, -- hide mapping boilerplate
    show_help = true, -- show a help message in the command line for using WhichKey
    show_keys = true, -- show the currently pressed key and its label as a message in the command line
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)
    wk.register(opts.defaults)
  end,
}
