-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

-- FIX: Override LazyVim's broken TextYankPost for Neovim 0.13-dev
-- LazyVim uses vim.hl.hl_op() which doesn't exist yet in 0.13-dev
-- Safely delete the LazyVim augroup if it exists
pcall(vim.api.nvim_del_augroup_by_name, "lazyvim_highlight_yank")

-- Create our own working version
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("custom_highlight_yank", { clear = true }),
  callback = function()
    -- Use the stable API that works in both 0.10+ and 0.13-dev
    vim.highlight.on_yank({ timeout = 200 })
  end,
})

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

-- Azure DevOps / Pipelines YAML files
-- Use a high-priority function pattern so it wins over the built-in .yaml extension match.
-- vim.filetype.add plain patterns lose to extension matching (.yaml -> 'yaml' always wins),
-- so we must use the {function, priority} form to override that.
vim.filetype.add({
  pattern = {
    ['.*'] = {
      priority = math.huge,
      function(path, _bufnr)
        -- Normalise to just the path string (may be relative or absolute)
        local p = path or ''
        if p:match('[/\\]%.azuredevops[/\\]') or p:match('^%.azuredevops[/\\]') then
          return 'yaml.azure'
        end
        if p:match('azure%-pipelines?.*%.ya?ml$') then
          return 'yaml.azure'
        end
      end,
    },
  },
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

-- Fallback BufRead autocmd for azure YAML detection (catches cases where filetype.add
-- may not fire, e.g. when neovim re-detects filetype after a plugin resets it).
vim.api.nvim_create_autocmd({ 'BufRead', 'BufNewFile' }, {
  pattern = { '*.yml', '*.yaml' },
  callback = function(ev)
    local path = vim.api.nvim_buf_get_name(ev.buf)
    if path == '' then return end
    if path:match('[/\\]%.azuredevops[/\\]') or path:match('^%.azuredevops[/\\]') then
      vim.bo[ev.buf].filetype = 'yaml.azure'
    elseif path:match('azure%-pipelines?.*%.ya?ml$') then
      vim.bo[ev.buf].filetype = 'yaml.azure'
    end
  end,
})

do
  local project_extra_paths = {
    'src',
    'src/nvim',
    'build/src/nvim',
    'build/src/nvim/auto',
  }
  local root_markers = {
    '.git',
    '.hg',
    '.bzr',
    '.svn',
    'package.json',
    'pyproject.toml',
    'go.mod',
    'Cargo.toml',
  }
  local uv = vim.uv
  local has_lazy_root, lazy_root = pcall(require, 'lazyvim.util.root')

  local function find_workspace_root(bufname, buf)
    if not bufname or bufname == '' then
      return nil
    end
    bufname = vim.fs.normalize(bufname)
    if has_lazy_root then
      local ok, workspace = pcall(lazy_root.get, { buf = buf, normalize = true })
      if ok and workspace and workspace ~= '' then
        return vim.fs.normalize(workspace)
      end
    end
    local dir = vim.fs.dirname(bufname)
    if dir and dir ~= '' then
      local workspace = vim.fs.root(dir, root_markers)
      if workspace and workspace ~= '' then
        return vim.fs.normalize(workspace)
      end
    end
    local cwd = uv.cwd()
    if cwd and cwd ~= '' then
      return vim.fs.normalize(cwd)
    end
    return nil
  end

  vim.api.nvim_create_autocmd('BufEnter', {
    group = vim.api.nvim_create_augroup('workspace_include_paths', { clear = true }),
    callback = function(event)
      local bufname = vim.api.nvim_buf_get_name(event.buf)
      if bufname == '' then
        return
      end
      local workspace_root = find_workspace_root(bufname, event.buf)
      if not workspace_root then
        return
      end
      if vim.b.workspace_repo_path_augmented then
        return
      end
      local existing = {}
      for _, entry in ipairs(vim.opt_local.path:get()) do
        existing[entry] = true
      end
      for _, rel in ipairs(project_extra_paths) do
        local full = vim.fs.normalize(vim.fs.joinpath(workspace_root, rel))
        local stat = uv.fs_stat(full)
        if stat and stat.type == 'directory' and not existing[full] then
          vim.opt_local.path:append(full)
        end
      end
      vim.b.workspace_repo_path_augmented = true
    end,
  })
end

local tbl_isarray = vim.tbl_isarray

local function encode_sorted_json(value, indent, depth)
  indent = indent or '  '
  depth = depth or 0
  if type(value) ~= 'table' then
    return vim.json.encode(value)
  end
  if tbl_isarray(value) then
    if #value == 0 then
      return '[]'
    end
    local parts = {}
    local child_indent = string.rep(indent, depth + 1)
    for idx, item in ipairs(value) do
      parts[idx] = child_indent .. encode_sorted_json(item, indent, depth + 1)
    end
    return '[\n' .. table.concat(parts, ',\n') .. '\n' .. string.rep(indent, depth) .. ']'
  end
  local keys = vim.tbl_keys(value)
  table.sort(keys, function(a, b)
    return tostring(a) < tostring(b)
  end)
  if #keys == 0 then
    return '{}'
  end
  local parts = {}
  local child_indent = string.rep(indent, depth + 1)
  for idx, key in ipairs(keys) do
    parts[idx] = child_indent .. vim.json.encode(key) .. ': ' .. encode_sorted_json(value[key], indent, depth + 1)
  end
  return '{\n' .. table.concat(parts, ',\n') .. '\n' .. string.rep(indent, depth) .. '}'
end

vim.lsp.commands['json.sort'] = function(_, ctx)
  local bufnr = ctx.bufnr
  if not vim.api.nvim_buf_is_valid(bufnr) or not vim.bo[bufnr].modifiable then
    return
  end
  local ft = vim.bo[bufnr].filetype
  if ft ~= 'json' and ft ~= 'jsonc' and ft ~= 'json5' then
    vim.notify('json.sort is only available in JSON buffers', vim.log.levels.WARN)
    return
  end
  local ok, decoded = pcall(
    vim.json.decode,
    table.concat(vim.api.nvim_buf_get_lines(bufnr, 0, -1, false), '\n'),
    { luanil = { object = true, array = true } }
  )
  if not ok then
    vim.notify('json.sort failed: ' .. decoded, vim.log.levels.ERROR)
    return
  end
  local sorted = encode_sorted_json(decoded)
  local lines = vim.split(sorted, '\n', { plain = true })
  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, lines)
end

-- LspInfo command to show attached clients
vim.api.nvim_create_user_command('LspInfo', function()
  local bufnr = vim.api.nvim_get_current_buf()
  local clients = vim.lsp.get_clients({ bufnr = bufnr })
  
  if #clients == 0 then
    vim.notify('No LSP clients attached to this buffer', vim.log.levels.INFO)
    return
  end
  
  local lines = { 'LSP clients attached to buffer ' .. bufnr .. ':' }
  for _, client in ipairs(clients) do
    table.insert(lines, string.format('  • %s (id: %d)', client.name, client.id))
    if client.config and client.config.root_dir then
      table.insert(lines, string.format('    root: %s', client.config.root_dir))
    end
  end
  
  vim.notify(table.concat(lines, '\n'), vim.log.levels.INFO)
end, { desc = 'Show LSP client info for current buffer' })
