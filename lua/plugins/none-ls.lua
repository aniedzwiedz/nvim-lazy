return {
  {
    "nvimtools/none-ls.nvim",
    event = "LazyFile",
    dependencies = { "mason.nvim" },
    -- init = function()
    --   Util.on_very_lazy(function()
    --     -- register the formatter with LazyVim
    --     require("lazyvim.util").format.register({
    --       name = "none-ls.nvim",
    --       priority = 200, -- set higher than conform, the builtin formatter
    --       primary = true,
    --       format = function(buf)
    --         return Util.lsp.format({
    --           bufnr = buf,
    --           filter = function(client)
    --             return client.name == "null-ls"
    --           end,
    --         })
    --       end,
    --       sources = function(buf)
    --         local ret = require("null-ls.sources").get_available(vim.bo[buf].filetype, "NULL_LS_FORMATTING") or {}
    --         return vim.tbl_map(function(source)
    --           return source.name
    --         end, ret)
    --       end,
    --     })
    --   end)
    -- end,
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.root_dir = opts.root_dir
        or require("null-ls.utils").root_pattern(".null-ls-root", ".neoconf.json", "Makefile", ".git")
      opts.sources = vim.list_extend(opts.sources or {}, {
        -- nls.builtins.formatting.stylua,
        nls.builtins.diagnostics.yamllint,
        -- nls.builtins.diagnostics.rubocop,
        nls.builtins.formatting.rubocop,
        -- nls.builtins.formatting.shfmt,
        -- nls.builtins.formatting.beautysh,
        nls.builtins.diagnostics.shellcheck,
        -- nls.builtins.completion.spell,
        nls.builtins.diagnostics.hadolint, -- docker none-ls
        -- nls.builtins.diagnostics.markdownlint,
        nls.builtins.formatting.isort,
        nls.builtins.formatting.terraform_fmt,
        -- nls.builtins.formatting.prettier.with({
        --   extra_filetypes = { "svelte" }, -- js/ts formatter
        -- }),
        nls.builtins.diagnostics.terraform_validate,
        nls.builtins.diagnostics.ansiblelint,
        -- nls.builtins.code_actions.gitsigns,
        -- nls.builtins.code_actions.shellcheck,
      })
    end,
  },
}
