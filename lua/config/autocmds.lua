-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

vim.api.nvim_create_autocmd('FileType', {
  group = vim.api.nvim_create_augroup('custom_markdown', { clear = true }),
  pattern = { 'markdown' },
  callback = function()
    vim.opt_local.cursorline = false -- doesn't look good when used with headline.nvim. toggle with leader-uL
    vim.opt_local.spell = false -- I find spellcheck only useful when writing prose. toggle with leader-us
    vim.opt_local.wrap = false -- inline links make wrapping very weird. toggle with leader-uw
    -- vim.opt_local.relativenumber = false
    vim.opt_local.number = false -- toggle with leader-ul
  end,
})

vim.filetype.add {
  extension = {
    tex = 'tex',
    zir = 'zir',
    cr = 'crystal',
  },
  pattern = {
    ['[jt]sconfig.*.json'] = 'jsonc',
  },
}

-- https://github.com/alesbrelih/gitlab-ci-ls
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = '.gitlab*',
  callback = function()
    vim.bo.filetype = 'yaml.gitlab'
  end,
})
-- Enable puppet
vim.api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' },
  -- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
  {
    pattern = { '*.pp' },
    callback = function()
      vim.opt.tabstop = 2
      vim.opt.softtabstop = 2
      vim.opt.shiftwidth = 2
      vim.opt.textwidth = 79
      vim.opt.expandtab = true
      vim.opt.autoindent = true
      vim.opt.fileformat = 'unix'
    end,
  }
)
-- Enable spell checking for certain file types
vim.api.nvim_create_autocmd(
  { 'BufRead', 'BufNewFile' },
  -- { pattern = { "*.txt", "*.md", "*.tex" }, command = [[setlocal spell<cr> setlocal spelllang=en,de<cr>]] }
  {
    pattern = { '*.txt', '*.md', '*.tex' },
    callback = function()
      vim.opt.spell = true
      vim.opt.spelllang = 'en,pl'
    end,
  }
)

-- Autocommands (https://neovim.io/doc/user/autocmd.html)
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { '*.json', '*.jsonc' },
  -- enable wrap mode for json files only
  command = 'setlocal wrap',
})

-- if a file is a .env or .envrc file, set the filetype to sh
vim.filetype.add {
  filename = {
    ['.env'] = 'sh',
    ['.envrc'] = 'sh',
    ['*.env'] = 'sh',
    ['*.envrc'] = 'sh',
  },
}

vim.api.nvim_create_autocmd('BufRead', {
  -- Force `Jenkinsfile` to groovy filetype.
  pattern = { 'Jenkinsfile' },
  command = 'set ft=groovy',
})
-- Advanced Gemfile

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { 'Gemfile.*' },
  -- enable wrap mode for json files only
  command = 'set filetype=ruby',
})
vim.api.nvim_create_autocmd('BufEnter', {
  pattern = { 'docker-compose*.ym*l' },
  -- enable wrap mode for json files only
  command = 'set filetype=yaml.docker-compose',
})
vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'gitcommit', 'NeogitCommitMessage' },
  callback = function()
    vim.opt.textwidth = 0
    vim.opt.wrapmargin = 0
    vim.opt.wrap = true
    vim.opt.linebreak = true
    vim.opt.columns = 80
    vim.opt.colorcolumn = '80'
    -- vim.opt_local.wrap = true
    vim.opt_local.spell = true
  end,
})

-- resize neovim split when terminal is resized
vim.api.nvim_command 'autocmd VimResized * wincmd ='

-- fix terraform and hcl comment string
-- vim.api.nvim_create_autocmd("FileType", {
--   group = api.nvim_create_augroup("FixTerraformCommentString", { clear = true }),
--   callback = function(ev)
--     vim.bo[ev.buf].commentstring = "# %s"
--   end,
--   pattern = { "terraform", "hcl" },
-- })
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    '*-ctl/*.yml',
    '*-ctl/*.yaml',
    '.*/tasks/.*.yaml',
    '.*/tasks/.*.yml',
  },
  callback = function()
    vim.bo.filetype = 'yaml.ansible'
  end,
})

vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = {
    '*azure-pipelines.yml',
    '*azure-pipelines.yaml',
    '*.azure/*.yml',
    '*.azure/*.yaml',
    '*.azuredevops/*.yml',
    '*.azuredevops/*.yaml',
    '*pipelines/*.yml',
    '*pipelines/*.yaml',
  },
  callback = function()
    vim.bo.filetype = 'yaml.azure'
  end,
})
