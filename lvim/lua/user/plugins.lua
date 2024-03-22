lvim.plugins = {
  -- colorscheme
  {
    'maxmx03/solarized.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.o.background = 'dark' -- or 'light'

      vim.cmd.colorscheme 'solarized'
    end,
  },


  -- list of errors
  {
    "folke/trouble.nvim",
    cmd = "TroubleToggle",
  },

  -- colored
  -- TODO:,
  -- NOTE:,
  -- FIXME:,
  -- WARNING:
  {
    "folke/todo-comments.nvim",
    event = "BufRead",
    config = function()
      require("todo-comments").setup()
    end
  },

  -- open files from the previous session
  {
    "folke/persistence.nvim",
    event = "BufReadPre",
    config = function()
      require("persistence").setup({
        dir = vim.fn.expand(vim.fn.stdpath "state" .. "/sessions/"),
        options = { "buffers", "curdir", "tabpages", "winsize" }
      })
    end
  },

  -- easy quoting
  { "tpope/vim-surround" },

  -- autoclose html tags
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },

  -- enhanced . behavior
  { "tpope/vim-repeat" },

  -- higlight the word under cursor
  -- TODO: doesn't work
  { "RRethy/vim-illuminate" },

  -- enhanced find behavior
  {
    'phaazon/hop.nvim',
    branch = 'v2',
    config = function()
      require('hop').setup()
    end
  },
}


-- to checkoout: copilot
-- {
--  "zbirenbaum/copilot.lua",
--  cmd = "Copilot",
--  event = "InsertEnter",
--  config = function()
--    require("copilot").setup({
--      suggestions = { enabled = false },
--      panel = { enabled = false },
--    })
--  end,
--},
--
-- copilot in suggestions
--  table.insert(lvim.plugins, {
--    "zbirenbaum/copilot-cmp",
--    event = "InsertEnter",
--    dependencies = { "zbirenbaum/copilot.lua" },
--    config = function()
--      local ok, cmp = pcall(require, "copilot_cmp")
--      if ok then cmp.setup({}) end
--    end,
--  }
