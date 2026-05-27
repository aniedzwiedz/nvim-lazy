# Copilot Instructions for nvim-lazy

This is a **LazyVim-based Neovim configuration** repository focused on developer productivity with AI integration, extensive language support, and modern tooling.

## Build & Development

### Dependencies
- **Neovim** >= 0.10.0 (v0.13.0+ recommended for latest native features)
- **Node.js** >= 18.0.0 (for LSP servers and GitHub Copilot)
- **Python** >= 3.8 (for Python LSP)
- **ripgrep** (fast searching), **fd** (fast file finding)
- Optional: **Yazi** (terminal file manager), **FZF** (fuzzy finder)

### Setup & Installation
```bash
npm install          # Install Node.js dependencies (mason servers, linting tools)
nvim                 # First launch auto-installs all plugins via lazy.nvim
:Lazy sync           # Inside Neovim: sync/update plugins
:LazyExtras          # Inside Neovim: manage LazyVim extras
:checkhealth         # Verify all systems working
:LazyHealth          # Check Lazy.nvim plugin health
```

### Code Quality
```bash
stylua lua/          # Format Lua files (2-space indent)
stylua --check lua/  # Check formatting without changing
```

**Key Conventions:**
- 2-space indents for Lua, JSON, YAML
- 4-space indents for Python
- EditorConfig enforced (see .editorconfig)
- Stylua config: 80 column width, Unix line endings

## Architecture & Organization

### Plugin Configuration Pattern
This config uses **lazy.nvim** for plugin management with specs defined as Lua tables. Key structure:

```lua
{
  'plugin/repo',              -- Required: plugin spec
  ft = 'filetype',           -- Optional: lazy load by filetype
  event = 'LazyFile',        -- Optional: lazy load by event
  keys = { ... },            -- Optional: lazy load by keybinds
  opts = { ... },            -- Plugin options/config
  config = function() end,   -- Custom setup after init
  dependencies = { ... },    -- Plugin dependencies
}
```

**Config Entry Points:**
- `init.lua` - Bootstraps lazy.nvim
- `lua/config/lazy.lua` - Lazy.nvim setup & plugin specs
- `lua/config/options.lua` - Vim options & global settings
- `lua/config/keymaps.lua` - Custom keybindings
- `lua/config/autocmds.lua` - Autocommands
- `lua/plugins/` - All plugin configurations

### Key Customizations in This Config
1. **Picker:** FZF is default (`vim.g.lazyvim_picker = 'fzf'`). Can switch to Telescope or Snacks in options.lua
2. **Formatting:** Auto-format disabled by default (`vim.g.autoformat = false`)
3. **Completion Engine:** Set via `:LazyExtras` or `vim.g.lazyvim_cmp = 'auto'`
4. **Root Detection:** LSP, `.git`/`lua` directories, then cwd (in `options.lua`)
5. **Native Features:** Uses native Neovim 0.10+ features (commenting, snippets, inlay hints, editorconfig) - see `NATIVE_FEATURES.md`

### Plugin Categories
- **AI:** Copilot, Copilot Chat, Sidekick (configured in user.lua)
- **Editor:** Neo-tree, FZF, Telescope, Mini.diff, Mini.indentscope
- **Formatting:** Conform (LSP + Prettier), Stylua for Lua
- **Linting:** Configured per-language via Mason
- **Git:** Gitsigns, Diffview, Git-conflict resolution
- **Languages:** 15+ language extras enabled (TS, Python, Go, Rust, Docker, Terraform, etc.)

### LazyVim Extras
All enabled extras defined in `lazyvim.json`. Includes AI tools, lang supports, formatting, and UI enhancements. Modify via `:LazyExtras` or edit the JSON file directly.

## Key Code Patterns

### Adding Custom Plugins
Add to `lua/plugins/user.lua` or create new files in `lua/plugins/`:

```lua
return {
  {
    'author/plugin',
    event = 'LazyFile',  -- When to load
    opts = { ... },      -- Config
    keys = {             -- Keybinds trigger loading
      { '<leader>x', function() ... end, desc = 'Action' },
    },
  },
}
```

### Keybinding Convention
- `<leader>` is the leader key (customizable in keymaps.lua)
- Prefix patterns: `<leader>e` (explorer), `<leader>g` (git), `<leader>f` (find), `<leader>c` (code)
- Two-character bindings group related functionality

### Global Options & Variables
Set in `lua/config/options.lua`:
- `vim.g.lazyvim_picker` - Active picker plugin
- `vim.g.autoformat` - Auto-format on save toggle
- `vim.g.root_spec` - Root directory detection
- Use `vim.opt.*` for Neovim options, `vim.g.*` for global settings

## Common Tasks

### Install/Update a Language Server
```vim
:Mason
# Then search and install, or use:
:MasonInstall rust-analyzer pyright typescript-language-server
```

### Enable/Disable a LazyVim Extra
```vim
:LazyExtras      # Interactive UI to toggle extras
```

### Debug LSP or Plugin Issues
```vim
:LspInfo         # Current LSP server status
:LazyHealth      # Plugin system health
:checkhealth     # Full system health report
```

### Add Custom Keybindings
Edit `lua/config/keymaps.lua` following existing patterns. Keybindings can also be added to individual plugin configs in `lua/plugins/`.

### Troubleshooting Copilot
```vim
:Copilot auth    # Authenticate with GitHub
:Copilot status  # Check connection/subscription
```

## Native Neovim Features

This config leverages native Neovim 0.10+ features instead of plugins where possible:
- **Commenting**: Native `gcc`, `gc{motion}`, `gbc` (no plugin needed)
- **Snippets**: Native `vim.snippet` API with `friendly-snippets` definitions
- **EditorConfig**: Built-in support (no plugin needed)
- **Inlay Hints**: Native `vim.lsp.inlay_hint` API
- **Disabled Plugins**: `ts-comments.nvim`, `mini.comment`, `indent-blankline.nvim`

See `NATIVE_FEATURES.md` for complete details.

## Testing & Validation

No dedicated test suite, but validate changes with:
```bash
nvim --noplugin           # Start without plugins to test core config
nvim -c "qa!" +LazyHealth # Run LazyHealth and exit
:checkhealth              # Full system diagnostic
```

