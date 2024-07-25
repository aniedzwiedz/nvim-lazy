return {
  {
    "NvChad/nvim-colorizer.lua",
    event = { "BufReadPre", "BufNewFile" },
    config = true,
    opts = {
      user_default_options = {
        names = false,
      },
    },
  },
  {
    "echasnovski/mini.indentscope",
    version = false, -- wait till new 0.7.0 release to put it back on semver
    event = "LazyFile",
    opts = {
      -- symbol = "▏",
      symbol = "⁝ ",
      options = {
        -- border = "both",
        indent_at_cursor = true,
        try_as_border = true,
      },
    },
    init = function()
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "help",
          "alpha",
          "dashboard",
          "neo-tree",
          "Trouble",
          "lazy",
          "mason",
          "notify",
          "toggleterm",
          "lazyterm",
        },
        callback = function()
          vim.b.miniindentscope_disable = true
        end,
      })
    end,
  },
  -- {
  --   "lukas-reineke/indent-blankline.nvim",
  --   event = "LazyFile",
  --   config = function()
  --     local highlight = {
  --       "RainbowRed",
  --       "RainbowYellow",
  --       "RainbowBlue",
  --       "RainbowOrange",
  --       "RainbowGreen",
  --       "RainbowViolet",
  --       "RainbowCyan",
  --     }
  --     local hooks = require("ibl.hooks")
  --     hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  --       vim.api.nvim_set_hl(0, "RainbowRed", { fg = "#E06C75" })
  --       vim.api.nvim_set_hl(0, "RainbowYellow", { fg = "#E5C07B" })
  --       vim.api.nvim_set_hl(0, "RainbowBlue", { fg = "#61AFEF" })
  --       vim.api.nvim_set_hl(0, "RainbowOrange", { fg = "#D19A66" })
  --       vim.api.nvim_set_hl(0, "RainbowGreen", { fg = "#98C379" })
  --       vim.api.nvim_set_hl(0, "RainbowViolet", { fg = "#C678DD" })
  --       vim.api.nvim_set_hl(0, "RainbowCyan", { fg = "#56B6C2" })
  --     end)
  --
  --     -- require("ibl").setup({ indent = { highlight = highlight } })
  --
  --     vim.g.rainbow_delimiters = { highlight = highlight }
  --     require("ibl").setup({
  --       scope = { highlight = highlight },
  --     })
  --
  --     hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
  --     -- require("ibl").setup({
  --     --   indent = { highlight = highlight, char = "" },
  --     --   whitespace = {
  --     --     highlight = highlight,
  --     --     remove_blankline_trail = false,
  --     --   },
  --     --   scope = { enabled = false },
  --     -- })
  --   end,
  --   opts = {
  --     -- scope = { enabled = false },
  --     exclude = {
  --       filetypes = {
  --         "help",
  --         "alpha",
  --         "dashboard",
  --         "neo-tree",
  --         "Trouble",
  --         "trouble",
  --         "lazy",
  --         "mason",
  --         "notify",
  --         "toggleterm",
  --         "lazyterm",
  --       },
  --     },
  --   },
  --   -- main = "ibl",
  -- },
}

-- local M = {
--   "NvChad/nvim-colorizer.lua",
--   event = { "BufReadPost", "BufNewFile" },
-- }
--
-- function M.config()
--   require("colorizer").setup {
--     filetypes = {
--       "typescript",
--       "typescriptreact",
--       "javascript",
--       "javascriptreact",
--       "css",
--       "html",
--       "astro",
--       "lua",
--     },
--     user_default_options = {
--       names = false,
--       rgb_fn = true,
--       tailwind = "both",
--     },
--     buftypes = {},
--   }
-- end
--
-- return M
