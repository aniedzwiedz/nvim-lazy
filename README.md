# � LazyVim Configuration

A powerful and modern Neovim configuration built on top of [LazyVim](https://www.lazyvim.org/), featuring extensive language support, AI integration, and developer productivity tools.

## ✨ Features

### 🤖 AI Integration
- **GitHub Copilot** - AI-powered code completion and suggestions
- **Copilot Chat** - Interactive AI assistant for code discussions
- **AI Sidekick** - Enhanced AI capabilities

### 🌈 User Interface
- **Catppuccin** colorscheme with transparency
- **Neo-tree** file explorer with floating window
- **Telescope** fuzzy finder with FZF integration
- **Mini.indentscope** for visual scope indication
- **Gitsigns** for Git integration in the gutter

### 📝 Language Support
- **TypeScript/JavaScript** - Full LSP support with formatting
- **Python** - Complete development environment
- **Go** - Go language support
- **Rust** - Rust development tools
- **Docker** - Dockerfile and Docker Compose support
- **Terraform** - Infrastructure as Code support
- **YAML/JSON** - Configuration file support
- **Markdown** - Documentation and note-taking
- **C/C++** - Native development with Clang
- **Ruby** - Ruby language support
- **Helm** - Kubernetes Helm chart support

### 🔧 Development Tools
- **Git Integration** - Advanced Git workflow tools
- **Diffview** - Side-by-side Git diff viewer
- **Git Conflict** - Merge conflict resolution
- **Package Info** - NPM package version information
- **Grug-far** - Advanced search and replace
- **Yazi** - Fast file manager integration

### ⚡ Productivity Features
- **FZF** as the default picker for blazing fast file navigation
- **WSL Clipboard** integration for seamless copy/paste
- **Background transparency** for modern terminal aesthetics
- **Smart indentation** and formatting
- **Advanced Git search** with Telescope integration
- **Visible whitespace** markers (tabs, trailing spaces, nbsp) for cleaner diffs

## 📋 Requirements

- **Neovim** >= 0.9.0
- **Git** >= 2.19.0
- **Node.js** >= 18.0.0 (for LSP servers and Copilot)
- **Python** >= 3.8 (for Python LSP)
- **Ripgrep** (for fast searching)
- **fd** (for fast file finding)
- **A Nerd Font** (recommended: LiterationMono Nerd Font Propo)

### Optional Dependencies
- **Yazi** - Terminal file manager
- **FZF** - Command-line fuzzy finder
- **PowerShell** - For WSL clipboard integration

## 🚀 Installation

1. **Backup your existing Neovim configuration:**
   ```bash
   mv ~/.config/nvim ~/.config/nvim.backup
   ```

2. **Clone this configuration:**
   ```bash
   git clone https://github.com/aniedzwiedz/nvim-lazy ~/.config/nvim-lazy
   ln -s ~/.config/nvim-lazy ~/.config/nvim
   ```

3. **Install dependencies:**
   ```bash
   # Install Node.js dependencies
   cd ~/.config/nvim-lazy
   npm install
   ```

4. **Start Neovim:**
   ```bash
   nvim
   ```

   LazyVim will automatically install all plugins on first launch.

## ⌨️ Key Mappings

### File Navigation
| Key | Description |
|-----|-------------|
| `<leader>e` | Toggle Neo-tree file explorer |
| `<leader>fx` | Open Yazi file manager |
| `_` | Open Yazi at current file |
| `<leader>fp` | Find plugin files |

### Git Operations
| Key | Description |
|-----|-------------|
| `<leader>gd` | Open Git diff view |
| `<F4>` | Close diff view |
| `<leader>gy` | Copy GitHub URL |
| `<leader>gxl` | List Git conflicts |
| `]h` / `[h` | Next/Previous Git hunk |
| `<leader>ghs` | Stage hunk |
| `<leader>ghr` | Reset hunk |

### Code Navigation
| Key | Description |
|-----|-------------|
| `<leader>cs` | Toggle code outline |
| `<leader>sr` | Search and replace (grug-far) |

## 🔧 Configuration Structure

```
├── init.lua                 # Entry point
├── lua/
│   ├── config/
│   │   ├── autocmds.lua    # Auto commands
│   │   ├── keymaps.lua     # Key mappings
│   │   ├── lazy.lua        # Lazy.nvim setup
│   │   └── options.lua     # Neovim options
│   └── plugins/            # Plugin configurations
│       ├── colorscheme.lua # Theme configuration
│       ├── conform.lua     # Code formatting
│       ├── copilotfix.lua  # Copilot fixes
│       ├── fzf.lua         # FZF integration
│       ├── telescope.lua   # Telescope configuration
│       └── user.lua        # Main user plugins
├── snippets/               # Custom code snippets
├── spell/                  # Spell check dictionaries
└── package.json           # Node.js dependencies
```

## 🎨 Customization

### Changing the Picker
The configuration uses FZF as the default picker. To change it:

```lua
-- In lua/config/options.lua
vim.g.lazyvim_picker = 'telescope'  -- or 'snacks'
```

### Modifying Theme
The configuration uses Catppuccin with transparency. To modify:

```lua
-- In lua/plugins/user.lua
{
  'catppuccin/nvim',
  opts = {
    transparent_background = false,  -- Disable transparency
    -- Add other customizations
  },
}
```

### Adding Custom Plugins
Add new plugins to `lua/plugins/user.lua` or create new files in the `lua/plugins/` directory.

## 📦 Included LazyVim Extras

This configuration includes numerous LazyVim extras for enhanced functionality:

- AI tools (Copilot, Copilot Chat, Sidekick)
- Coding enhancements (Mini Surround, Neogen)
- Editor improvements (FZF, Telescope, Neo-tree)
- Language support for 15+ languages
- Formatting and linting tools
- Git integration
- VSCode compatibility

## 🔄 Updates

To update the configuration and plugins:

```bash
# Update LazyVim and plugins
:Lazy update

# Update LazyVim extras
:LazyExtras
```

## 🐛 Troubleshooting

### Common Issues

1. **Clipboard not working in WSL:**
   - Ensure PowerShell is available in WSL
   - Check WSL clipboard configuration in `options.lua`

2. **LSP servers not working:**
   - Run `:Mason` to install language servers
   - Check `:LspInfo` for server status

3. **Copilot not working:**
   - Run `:Copilot auth` to authenticate
   - Check `:Copilot status`

### Health Checks
```bash
:checkhealth
:LazyHealth
```

## 🤝 Contributing

Feel free to submit issues and pull requests to improve this configuration.

## 📄 License

This configuration is licensed under the MIT License. See [LICENSE](LICENSE) for details.

## 🙏 Acknowledgments

- [LazyVim](https://www.lazyvim.org/) - The excellent Neovim distribution this config is based on
- [Folke Lemaitre](https://github.com/folke) - Creator of LazyVim and many plugins
- [Catppuccin](https://catppuccin.com/) - Beautiful color scheme
- The Neovim community for the amazing ecosystem

---

**Happy coding! 🎉**
