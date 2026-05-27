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
