-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = require('lazyvim.util').safe_keymap_set

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
  Snacks.picker.projects { limit = 100 }
end, { desc = 'Find [P]rojects' })

-- copy path (Spacemacs-style <leader>fy)
-- lowercase = relative to project root, UPPERCASE = absolute
local copy_path = require 'util.copy_path'
map('n', '<leader>fyy', copy_path.copy_relative, { desc = 'Path (relative)' })
map('n', '<leader>fyY', copy_path.copy_absolute, { desc = 'Path (absolute)' })
map(
  'n',
  '<leader>fyl',
  copy_path.copy_relative_with_line,
  { desc = 'Path (relative, :line)' }
)
map(
  'n',
  '<leader>fyL',
  copy_path.copy_absolute_with_line,
  { desc = 'Path (absolute, :line)' }
)
map(
  'n',
  '<leader>fyc',
  copy_path.copy_relative_with_line_column,
  { desc = 'Path (relative, :line:col)' }
)
map(
  'n',
  '<leader>fyC',
  copy_path.copy_absolute_with_line_column,
  { desc = 'Path (absolute, :line:col)' }
)
map(
  'n',
  '<leader>fyd',
  copy_path.copy_relative_directory,
  { desc = 'Directory (relative)' }
)
map(
  'n',
  '<leader>fyD',
  copy_path.copy_absolute_directory,
  { desc = 'Directory (absolute)' }
)
map('n', '<leader>fyP', copy_path.copy_project, { desc = 'Project Root' })
map('n', '<leader>fyn', copy_path.copy_filename, { desc = 'Filename' })
map(
  'n',
  '<leader>fyN',
  copy_path.copy_filename_no_ext,
  { desc = 'Filename (no ext)' }
)

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
