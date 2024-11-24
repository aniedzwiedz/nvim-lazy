local icons = require("icons")

require("gitsigns").setup({
  signs = {
    add = {
      -- hl = "GitSignsAdd",
      text = icons.ui.BoldLineMiddle,
      -- numhl = "GitSignsAddNr",
      -- linehl = "GitSignsAddLn",
    },
    change = {
      -- hl = "GitSignsChange",
      text = icons.ui.BoldLineDashedMiddle,
      -- numhl = "GitSignsChangeNr",
      -- linehl = "GitSignsChangeLn",
    },
    delete = {
      -- hl = "GitSignsDelete",
      text = icons.ui.TriangleShortArrowRight,
      -- numhl = "GitSignsDeleteNr",
      -- linehl = "GitSignsDeleteLn",
    },
    topdelete = {
      -- hl = "GitSignsDelete",
      text = icons.ui.TriangleShortArrowRight,
      -- numhl = "GitSignsTopDeleteNr",
      -- linehl = "GitSignsDeleteLn",
    },
    changedelete = {
      -- hl = "GitSignsChange",
      text = icons.ui.BoldLineMiddle,
      -- numhl = "GitSignsChangeNr",
      -- linehl = "GitSignsChangeLn",
    },
  },
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
  update_debounce = 200,
  max_file_length = 40000,
  preview_config = {
    border = "rounded",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
})
-- WhichKey
local which_key = require("which-key")
which_key.setup({
  preset = "helix",
  plugins = {
    marks = true,
    registers = true,
    spelling = {
      enabled = true,
      suggestions = 20,
    },
    presets = {
      operators = false,
      motions = false,
      text_objects = false,
      windows = false,
      nav = false,
      z = false,
      g = false,
    },
  },
  win = {
    border = "rounded",
    no_overlap = false,
    padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
    title = false,
    title_pos = "center",
    zindex = 1000,
  },
  -- ignore_missing = true,
  show_help = false,
  show_keys = false,
  disable = {
    buftypes = {},
    filetypes = { "TelescopePrompt" },
  },
})

local wk = require("which-key")
