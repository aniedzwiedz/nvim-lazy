-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here
local addtype = vim.filetype.add

-- Disable autoformat for lua files
-- vim.api.nvim_create_autocmd({ "FileType" }, {
--   pattern = { "bash", "zsh", "yml" },
--   callback = function()
--     ---@diagnostic disable-next-line: inject-field
--     vim.b.autoformat = false
--   end,
-- })

-- Format buffer with conform -- https://github.com/stevearc/conform.nvim
-- vim.api.nvim_create_autocmd("BufWritePre", {
--   pattern = "*",
--   callback = function(args)
--     require("conform").format({ bufnr = args.buf })
--   end,
-- })

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "sh",
  callback = function()
    vim.lsp.start({
      name = "bash-language-server",
      cmd = { "bash-language-server", "start" },
    })
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "netrw",
    "Jaq",
    "qf",
    "git",
    "help",
    "man",
    "lspinfo",
    "spectre_panel",
    "lir",
    "DressingSelect",
    "tsplayground",
    "",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- Set Jenkinsfile filetype before all other code execution.
addtype({
  pattern = {
    [".*.groovy"] = function(_, bufnr)
      local content = vim.filetype.getlines(bufnr, 1)
      if vim.filetype.matchregex(content, [[.*filetype=Jenkinsfile.*]]) then
        return "Jenkinsfile"
      else
        return "groovy"
      end
    end,
  },
})

-- Ansible support
-- vim.api.nvim_create_autocmd("BufEnter", {
--   pattern = { "*.yml" },
--   -- command = "setfiletype yaml.ansible",
--   callback = function()
--     -- let treesitter use bash highlight for zsh files as well
--     require("lvim.lsp.manager").setup("ansiblels", opts)
--   end,
-- })
--
-- local function set_ansible(bufnr)
--   local content = vim.filetype.getlines(bufnr, 1, 10)
--   local matcher = { "^- hosts:", "^- name:" }
--   local doset = false
--   for _, m in ipairs(matcher) do
--     for _, c in ipairs(content) do
--       if string.match(c, m) then
--         doset = true
--       end
--     end
--   end
--   if doset then
--     return "yaml.ansible"
--   else
--     return "yaml"
--   end
-- end
-- addtype({
--   pattern = {
--     [".*.yaml"] = function(_, bufnr)
--       return set_ansible(bufnr)
--     end,
--     [".*.yml"] = function(_, bufnr)
--       return set_ansible(bufnr)
--     end,
--   },
-- })
