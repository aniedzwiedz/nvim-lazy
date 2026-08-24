local java_filetypes = { 'java' }

local bundles = {
  '/home/aniedzwiedz/.local/share/AstroNvim_Eryk/mason/packages/java-debug-adapter/extension/server/com.microsoft.java.debug.plugin-0.53.1.jar'
}

bundles = vim.tbl_filter(function(bundle)
  return vim.uv.fs_stat(bundle) ~= nil
end, bundles)

return {
  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        jdtls = {},
      },
      setup = {
        jdtls = function()
          return true
        end,
      },
    },
  },

  {
    'mfussenegger/nvim-jdtls',
    ft = java_filetypes,
    opts = {
      init_options = {
        bundles = bundles,
      },
      settings = {
        java = {
          signatureHelp = { enabled = true },
        },
      },
    },
    config = function(_, opts)
      local function start_jdtls()
        local root_dir = vim.fs.root(0, {
          '.git',
          'build.gradle',
          'build.gradle.kts',
          'build.xml',
          'pom.xml',
          'settings.gradle',
          'settings.gradle.kts',
        })
        if not root_dir then
          return
        end

        local project_name = vim.fs.basename(root_dir)
        local workspace_dir = vim.fn.stdpath 'cache'
          .. '/jdtls/'
          .. project_name

        -- Merge LazyVim's java extra opts first, then force our own
        -- resolved (string) values on top. LazyVim's extra sets
        -- `root_dir`/`project_name`/etc. as *functions*, which nvim-HEAD
        -- passes straight to the process spawn as `cwd`, causing:
        --   "bad argument #2 to 'spawn' (cwd option must be string)"
        local config = vim.tbl_deep_extend('force', opts, {
          cmd = { 'jdtls', '-data', workspace_dir },
          root_dir = root_dir,
        })

        -- Drop any leftover function-valued fields the extra injected that
        -- must not reach the LSP client / spawn options.
        for _, key in ipairs({ 'project_name', 'jdtls_config_dir', 'jdtls_workspace_dir', 'full_cmd' }) do
          config[key] = nil
        end

        require('jdtls').start_or_attach(config)
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = java_filetypes,
        callback = start_jdtls,
      })

      start_jdtls()
    end,
  },
}
