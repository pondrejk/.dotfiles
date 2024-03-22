local kind = require('user.kind')
local wk = lvim.builtin.which_key

-- session management persistence.vim
wk.mappings["S"] = {
  name = "restore session",
  s = { "<cmd>lua require('persistence').load()<cr>", kind.icons.clock .. " Reload last session for dir" },
  l = { "<cmd>lua require('persistence').load({ last = true })<cr>", kind.icons.clock .. " Restore last session" },
  Q = { "<cmd>lua require('persistence').stop()<cr>", kind.icons.exit .. " Quit without saving session" },
}

-- toggle format on save
wk.mappings["l"]["t"] = { ":LvimToggleFormatOnSave<cr>", kind.symbols_outline.File .. " Toggle format-on-save" }

-- restart LSP
wk.mappings["l"]["R"] = { ":LspRestart<cr>", kind.icons.exit .. " Restart" }

-- search word under cursor   TODO: debug
wk.mappings["s"]["w"] = {
  "<cmd>lua require('telescope.builtin').grep_string({ search = vim.fn.expand('<cword>') })<cr>",
  ' ' .. kind.cmp_kind.EnumMember .. " Search Word Under Cursor"
}

--  wk.mappings["G"] = {
--    name = ' ' .. kind.icons.hint .. " Github Copilot",
--    a = { ":lua require('copilot.suggestion').accept()<cr>", "Accept" },
--    n = { ":lua require('copilot.suggestion').next()<cr>", "Next" },
--    N = { ":lua require('copilot.suggestion').prev()<cr>", "Prev" },
--    d = { ":lua require('copilot.suggestion').dismiss()<cr>", "Dismiss" },
--    t = { ":lua require('copilot.suggestion').toggle_auto_trigger()<cr>", "Toggle Auto Trigger" },
--  }

wk.mappings['x'] = { ":xa<cr>", "Save All and Quit", }

wk.mappings["t"] = {
  name = 'Telescope',
  p = { ':Telescope projects<cr>', 'Projects' }, -- requires telescope-project.nvim plugin
  r = { ':Telescope resume<cr>', 'Resume' },
}
