# Native Neovim 0.13.0 Features

This configuration has been optimized to use native Neovim features instead of plugins where possible.

## Native Features Being Used

### 1. **EditorConfig Support** (Native since 0.9+)
- **Status**: ✅ Already configured
- **File**: `lua/plugins/editorconfig.lua` returns `{}`
- **Usage**: Automatic via `runtime/plugin/editorconfig.lua`
- **Disable per buffer**: `vim.b.editorconfig = false`
- **Disable globally**: `vim.g.editorconfig = false`

### 2. **Commenting** (Native since 0.10+)
- **Status**: ✅ Now using native
- **Keybindings**: 
  - `gc{motion}` - Comment/uncomment motion
  - `gcc` - Comment/uncomment line
  - `gbc` - Block comment
- **Removed**: `ts-comments.nvim` plugin (disabled in `lua/plugins/native-features.lua`)
- **Doc**: `:help commenting`

### 3. **Snippets** (Native since 0.10+)
- **Status**: ✅ Using native with snippet definitions
- **Implementation**: `vim.snippet` API
- **Config**: `vim.g.lazyvim_mini_snippets_in_completion = true` in `options.lua`
- **Kept**: `friendly-snippets` provides snippet definitions compatible with native API
- **Doc**: `:help vim.snippet`

### 4. **LSP Inlay Hints** (Native since 0.10+)
- **Status**: ✅ Native support available
- **API**: `vim.lsp.inlay_hint.enable()` / `vim.lsp.inlay_hint.is_enabled()`
- **Toggle**: LazyVim provides `<leader>uh` to toggle
- **Doc**: `:help vim.lsp.inlay_hint`

### 5. **Indent Guides**
- **Status**: ✅ Already disabled
- **File**: `lua/plugins/user.lua` has `indent-blankline.nvim` commented out
- **Using**: `mini.indentscope` for current scope (not a duplicate - different feature)

### 6. **Image Display** (Experimental in 0.13-dev)
- **Status**: ⚠️ Experimental
- **API**: `vim.ui.img` module for displaying images within Neovim
- **Note**: This is an experimental feature in Neovim 0.13-dev
- **Doc**: `:help vim.ui.img` (when available)

## Plugins That Are NOT Duplicates

These plugins provide functionality beyond native features:

- **mini.surround** - Surround operations (no native equivalent)
- **mini.pairs** - Auto-pair brackets (no native equivalent)
- **mini.ai** - Enhanced text objects (extends native)
- **mini.indentscope** - Visual scope indicator (different from indent guides)
- **gitsigns** - Git integration in sign column
- **telescope/fzf-lua** - Fuzzy finding UI
- **treesitter** - Enhanced syntax parsing
- **LSP plugins** - Language server management

## Verification

Check that native features are working:

```vim
:help commenting
:help vim.snippet
:help vim.lsp.inlay_hint
:help editorconfig

" Test native commenting
gcc  " Comment current line
gc2j " Comment 2 lines down
```

## References

- Neovim 0.10 Release Notes: https://neovim.io/doc/user/news-0.10.html
- Native Commenting: `:help commenting`
- Native Snippets: `:help vim.snippet`
- EditorConfig: `:help editorconfig`

---

## See Also

- **[FORMATTER_LINTER_UPDATES.md](./FORMATTER_LINTER_UPDATES.md)** - Updated formatters and linters configuration (2026)

---

## 🐛 Bug Fixes for Neovim 0.13-dev

### TextYankPost Error Fix

**Problem:**
LazyVim's `autocmds.lua` uses `vim.hl.hl_op()` for Neovim 0.13, but this API doesn't exist yet in 0.13-dev, causing errors when yanking text:
```
Error: attempt to call field 'hl_op' (a nil value)
```

**Solution:**
Override the broken autocmd in `lua/config/autocmds.lua`:

```lua
-- FIX: Override LazyVim's broken TextYankPost for Neovim 0.13-dev
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_highlight_yank")

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("custom_highlight_yank", { clear = true }),
  callback = function()
    -- Use the stable API that works in both 0.10+ and 0.13-dev
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
```

**Status:** ✅ Fixed in `lua/config/autocmds.lua`

---

*Last updated: 2026-06-03*
