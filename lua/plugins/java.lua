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

        require('jdtls').start_or_attach(vim.tbl_deep_extend('force', {
          cmd = { 'jdtls', '-data', workspace_dir },
          root_dir = root_dir,
        }, opts))
      end

      vim.api.nvim_create_autocmd('FileType', {
        pattern = java_filetypes,
        callback = start_jdtls,
      })

      start_jdtls()
    end,
  },
}
