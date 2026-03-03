-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = require('lazyvim.util').safe_keymap_set

-- Helper function
local function copy_to_clipboards(str)
  vim.fn.setreg('"', str)
  vim.fn.setreg('+', str)
  vim.notify('→ ' .. str)
end

-- ============================================================================
-- CLIPBOARD
-- ============================================================================
map({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Yank to clipboard' })
map('v', '<C-c>', '"+y', { desc = 'Copy to clipboard' })
map('i', '<C-S-v>', '"+p', { desc = 'Paste from clipboard' })

-- ============================================================================
-- FILES & PATHS
-- ============================================================================
map('n', '<leader>fC', function()
  Snacks.picker.lazy()
end, { desc = 'LazyVim config' })

map('n', '<leader>fP', function()
  Snacks.picker.projects({ limit = 100 })
end, { desc = 'Find [P]rojects' })

map('n', '<leader>fya', function()
  copy_to_clipboards(vim.fn.expand '%:p')
end, { desc = 'Copy absolute path to clipboard' })

map('n', '<leader>fyr', function()
  copy_to_clipboards(vim.fn.expand '%:.')
end, { desc = 'Copy relative path to clipboard' })

map('n', '<leader>fyn', function()
  copy_to_clipboards(vim.fn.expand '%:t')
end, { desc = 'Copy filename to clipboard' })

-- ============================================================================
-- SEARCH & PICKERS
-- ============================================================================
map('n', '<C-p>', function()
  Snacks.picker.git_files {
    layout = { preset = 'vscode' },
    untracked = true,
    hidden = true,
  }
end, { desc = 'Find Files (root dir)' })

map('n', '?', function()
  Snacks.picker.lines()
end, { desc = 'Search in lines' })

map('n', '<leader>sH', function()
  Snacks.picker.man()
end, { desc = 'Search in MANuals' })

map(
  'n',
  '<leader>cS',
  '<cmd>FzfLua lsp_finder<CR>',
  { desc = 'FzfLua lsp_finder' }
)

map({ 'i' }, '<C-x><C-f>', function()
  require('fzf-lua').complete_file {
    cmd = 'rg --files',
    winopts = { preview = { hidden = true } },
  }
end, { silent = true, desc = 'Fuzzy complete file' })

map('n', 'z=', function()
  require('fzf-lua').spell_suggest()
end, { silent = true, desc = 'FzfLua Spell Suggest' })

-- ============================================================================
-- GIT
-- ============================================================================
local ok_gitsigns, gitsigns = pcall(require, 'gitsigns')
if ok_gitsigns then
  map('n', '<leader>ub', function()
    gitsigns.toggle_current_line_blame()
  end, { desc = 'Toggle current line blame' })

  map('n', '<leader>gl', function()
    gitsigns.blame_line { full = false }
  end, { desc = 'View full Blame' })

  map('n', '<leader>gL', function()
    gitsigns.blame_line { full = true }
  end, { desc = 'View full Git Blame' })
end

-- ============================================================================
-- LSP & DIAGNOSTICS
-- ============================================================================
map('n', '<leader>uD', function()
  vim.diagnostic.config { virtual_text = false }
end, { desc = 'Toggle Diagnostics virtual_text' })

-- ============================================================================
-- EDITING
-- ============================================================================
map(
  'n',
  '<F2>',
  [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]],
  { noremap = true, silent = false, desc = 'Change word under cursor' }
)

-- ============================================================================
-- KEYMAP DELETIONS
-- ============================================================================
vim.keymap.del('n', '<leader>E')

-- ============================================================================
-- VSCODE SPECIFIC
-- ============================================================================
if vim.g.vscode then
  local vscode = function(action)
    return function()
      require('vscode').call(action)
    end
  end

  map(
    'n',
    ']d',
    vscode 'editor.action.marker.next',
    { desc = 'Next Diagnostic' }
  )
  map(
    'n',
    '[d',
    vscode 'editor.action.marker.previous',
    { desc = 'Prev Diagnostic' }
  )
  map(
    'n',
    'gr',
    vscode 'editor.action.goToReferences',
    { desc = 'Goto References' }
  )
  map(
    'n',
    'gd',
    vscode 'editor.action.revealDefinition',
    { desc = 'Goto Definition' }
  )
  map(
    'n',
    'gy',
    vscode 'editor.action.goToTypeDefinition',
    { desc = 'Goto Type Definition' }
  )
end
