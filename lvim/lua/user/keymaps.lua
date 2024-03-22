-----------------------------------------------------------
-- Define keymaps of Neovim and installed plugins.
-----------------------------------------------------------

local kind = require('user.kind')

local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then
    options = vim.tbl_extend('force', options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Change leader to a comma
vim.g.mapleader = ','

-----------------------------------------------------------
-- Neovim shortcuts
-----------------------------------------------------------

-- Map Esc to kk
map('i', 'jj', '<Esc>')

-- Clear search highlighting with Ctrl and l
map('n', '<C-l>', ':nohl<CR>')

-- gr lists references in telescope window
lvim.lsp.buffer_mappings.normal_mode["gr"] = {
  ":lua require'telescope.builtin'.lsp_references()<cr>",
  kind.cmp_kind.Reference .. " Find references"
}

-- gd opens telescope window when multiple definitions exist
lvim.lsp.buffer_mappings.normal_mode["gd"] = {
  ":lua vim.lsp.buf.definition()<cr>",
  -- ":lua require'telescope.builtin'.lsp_definitions()<cr>",
  kind.cmp_kind.Reference .. " Definitions"
}

-- Enhance the vertical movement over wrapped text:
map('n', 'k', 'gk')
map('n', 'j', 'gj')
map('n', '<Up>', 'g<Up>')
map('n', '<Down>', 'g<Down>')
map('i', '<Up>', '<Esc>g<Up>a')
map('i', '<Down>', '<Esc>g<Down>a')

-- move betw windows 
-- (doesn't work in gnome-terminal, works in alacritty)
map('n', '<A-j>', '<C-W>l')
map('i', '<A-j>', '<C-O><C-W>l')
map('c', '<A-j>', '<C-C><C-W>l')

map('n', '<A-k>', '<C-W>h')
map('i', '<A-k>', '<C-O><C-W>h')
map('c', '<A-k>', '<C-C><C-W>h')

-- ^yank copies whole word
map('n', '<S-y>', 'yaw')

-- move between buffers
map('n', '<C-j>', ':bprevious<CR>') 
map('n', '<C-k>', ':bnext<CR>') 

-- TODO: folding not working
-- fold with ,
map('n', ',', 'za')

-- TODO: move between the tabs
--lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
--lvim.keys.normal_mode["<S-l>"] = ":BufferLineCycleNext<CR>"
--lvim.keys.normal_mode["<S-h>"] = ":BufferLineCyclePrev<CR>"
--vim.keymap.set('n', 'gn', ":tabe %<CR>")
