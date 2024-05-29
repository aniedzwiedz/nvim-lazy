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

-- https://github.com/alesbrelih/gitlab-ci-ls
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = ".gitlab*",
  callback = function()
    vim.bo.filetype = "yaml.gitlab"
  end,
})

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "*.json", "*.jsonc" },
  -- enable wrap mode for json files only
  command = "setlocal wrap",
})

vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "Jenkinsfile" },
  -- enable wrap mode for json files only
  command = "set filetype=groovy",
})

-- -- Set Jenkinsfile filetype before all other code execution.
-- addtype({
--   pattern = {
--     [".*.groovy"] = function(_, bufnr)
--       local content = vim.api.nvim_buf_get_lines(bufnr, 1, 3, false)
--       local type = "groovy"
--       for _, c in ipairs(content) do
--         if string.match(c, [[.*filetype=Jenkinsfile.*]]) then
--           type = "Jenkinsfile"
--         end
--       end
--       return type
--     end,
--   },
-- })
--
vim.api.nvim_create_autocmd("BufEnter", {
  pattern = { "docker-compose*.ym*l" },
  -- enable wrap mode for json files only
  command = "set filetype=yaml.docker-compose",
})
-- vim.api.nvim_create_autocmd("FileType", {
--   pattern = "sh",
--   callback = function()
--     vim.lsp.start({
--       name = "bash-language-server",
--       cmd = { "bash-language-server", "start" },
--     })
--   end,
-- })

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = { "gitcommit", "markdown" },
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- close some filetypes with <q>
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
    "PlenaryTestPopup",
    "help",
    "lspinfo",
    "man",
    "notify",
    "qf",
    "query",
    "spectre_panel",
    "startuptime",
    "tsplayground",
    -- "neotest-output",
    "checkhealth",
    "neotest-summary",
    "neotest-output-panel",
    "aerial",
    "",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      set nobuflisted
    ]])
  end,
})

-- resize neovim split when terminal is resized
vim.api.nvim_command("autocmd VimResized * wincmd =")

-- fix terraform and hcl comment string
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
  callback = function(ev)
    vim.bo[ev.buf].commentstring = "# %s"
  end,
  pattern = { "terraform", "hcl" },
})

-- Run gofmt + goimport on save
local goimport_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
    require("go.format").goimport()
  end,
  group = goimport_sync_grp,
})
-- go to last loc when opening a buffer
-- vim.api.nvim_create_autocmd("BufReadPost", {
--   callback = function()
--     local mark = vim.api.nvim_buf_get_mark(0, '"')
--     local lcount = vim.api.nvim_buf_line_count(0)
--     if mark[1] > 0 and mark[1] <= lcount then
--       pcall(vim.api.nvim_win_set_cursor, 0, mark)
--     end
--   end,
-- })
--
-- Set Jenkinsfile filetype before all other code execution.
-- addtype({
--   pattern = {
--     [".*.groovy"] = function(_, bufnr)
--       local content = vim.filetype.getlines(bufnr, 1)
--       if vim.filetype.matchregex(content, [[.*filetype=Jenkinsfile.*]]) then
--         return "Jenkinsfile"
--       else
--         return "groovy"
--       end
--     end,
--   },
-- })

-- -- Ansible support NOTE: moved to ftdetect/ansible.vim
--
-- vim.api.nvim_create_autocmd("BufEnter", {
--   -- pattern = {"*ctl*.yml", "*.yml" },
--   pattern = { "*ctl*.yml", ".*/tasks/.*.y*ml", "*/playbooks/*.yml", "*.yml" },
--   -- command = "setfiletype yaml.ansible",
--   callback = function()
--     -- require("lvim.lsp.manager").setup("ansiblels", opts)
--     require("lspconfig.configs")
--   end,
-- })
-- --
-- local function set_yaml(bufnr)
--   local content = vim.api.nvim_buf_get_lines(bufnr, 1, 10, false)
--   local filename = vim.api.nvim_buf_get_name(bufnr)
--   local matcher = { "^- hosts:", "^- name:" }
--   local type = "yaml"
--   if string.find(filename, "templates") then
--     type = "helm"
--   end
--   for _, m in ipairs(matcher) do
--     for _, c in ipairs(content) do
--       if string.match(c, m) then
--         type = "yaml.ansible"
--       end
--     end
--   end
--   return type
-- end
-- addtype({
--   pattern = {
--     [".*.yaml"] = function(_, bufnr)
--       return set_yaml(bufnr)
--     end,
--     [".*.yml"] = function(_, bufnr)
--       return set_yaml(bufnr)
--     end,
--   },
-- })

-- Advanced Gemfile
addtype({
  pattern = {
    ["Gemfile.*"] = function(_, _)
      return "ruby"
    end,
  },
})

-- return {
--   polish = function()
--     local function yaml_ft(path, bufnr)
--       -- get content of buffer as string
--       local content = vim.filetype.getlines(bufnr)
--       if type(content) == "table" then
--         content = table.concat(content, "\n")
--       end
--
--       -- check if file is in roles, tasks, or handlers folder
--       local path_regex = vim.regex("(tasks\\|roles\\|handlers)/")
--       if path_regex and path_regex:match_str(path) then
--         return "yaml.ansible"
--       end
--       -- check for known ansible playbook text and if found, return yaml.ansible
--       local regex = vim.regex("hosts:\\|tasks:")
--       if regex and regex:match_str(content) then
--         return "yaml.ansible"
--       end
--
--       -- return yaml if nothing else
--       return "yaml"
--     end
--
--     vim.filetype.add({
--       extension = {
--         yml = yaml_ft,
--         yaml = yaml_ft,
--       },
--     })
--   end,
-- }
