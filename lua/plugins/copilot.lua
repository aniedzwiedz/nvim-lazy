return {
  'zbirenbaum/copilot.lua',
  optional = true,
  opts = function(_, opts)
    opts.server_opts_overrides = opts.server_opts_overrides or {}
    opts.server_opts_overrides.settings = vim.tbl_deep_extend('force', opts.server_opts_overrides.settings or {}, {
      telemetry = {
        telemetryLevel = 'none',
      },
    })
  end,
}
