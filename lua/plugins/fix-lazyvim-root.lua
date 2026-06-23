-- Workaround for: E5108: attempt to index local 'path' (a function value)
--   at lazy/core/util.lua:75 (norm) called from lazyvim/util/root.lua:46
--
-- Cause: With Neovim 0.13 nightly + recent nvim-lspconfig, some LSP clients
-- have `client.root_dir` set to a function (the new vim.lsp.config API allows
-- `root_dir = fun(bufnr, on_dir)`). LazyVim.norm assumes a string and crashes.
--
-- This fix:
--   1. Hardens LazyVim.norm to accept non-string input gracefully.
--   2. Patches lazyvim.util.root.detectors.lsp to skip function root_dir
--      values (or call them synchronously isn't safe, so we just drop them
--      and rely on workspace_folders / pattern / cwd detectors).
--
-- Remove this file once LazyVim handles the new API upstream.

return {
  {
    'LazyVim/LazyVim',
    init = function()
      -- Defer until LazyVim is loaded.
      local ok_lv, LazyVim = pcall(require, 'lazyvim.util')
      if not ok_lv then
        return
      end

      -- 1. Harden norm so any non-string path becomes nil instead of crashing.
      local original_norm = LazyVim.norm
      ---@diagnostic disable-next-line: duplicate-set-field
      LazyVim.norm = function(path)
        if type(path) ~= 'string' then
          return nil
        end
        return original_norm(path)
      end

      -- 2. Replace the LSP detector to skip function-typed root_dir.
      local ok_root, root = pcall(require, 'lazyvim.util.root')
      if not ok_root then
        return
      end

      root.detectors.lsp = function(buf)
        local bufpath = root.bufpath(buf)
        if not bufpath then
          return {}
        end
        local roots = {} ---@type string[]
        local clients = vim.lsp.get_clients { bufnr = buf }
        clients = vim.tbl_filter(function(client)
          return not vim.tbl_contains(vim.g.root_lsp_ignore or {}, client.name)
        end, clients)
        for _, client in pairs(clients) do
          local workspace = client.config and client.config.workspace_folders
          for _, ws in pairs(workspace or {}) do
            roots[#roots + 1] = vim.uri_to_fname(ws.uri)
          end
          -- Only accept string root_dir; new vim.lsp.config API permits a
          -- function which has not yet been resolved on this client.
          if type(client.root_dir) == 'string' then
            roots[#roots + 1] = client.root_dir
          end
        end
        return vim.tbl_filter(function(path)
          if type(path) ~= 'string' then
            return false
          end
          path = LazyVim.norm(path)
          return path and bufpath:find(path, 1, true) == 1
        end, roots)
      end
    end,
  },
}
