-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local map = vim.api.nvim_set_keymap
local opts = { noremap = true, silent = true }

-- ノーマルモードに戻る
map('i', 'jj', '<Esc>', opts)

map('n', '<leader>ff', '<cmd>Telescope find_files<cr>', opts)
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>', opts)
map('n', '<leader>ft', '<cmd>Telescope current_buffer_fuzzy_find<cr>', opts)

-- プロジェクトマネージャーを開く
map('n', '<leader>p', '<cmd>NeovimProjectDiscover<cr>', opts)
-- map('n', '<leader>pp', '<cmd>NeovimProjectHistory<cr>', opts)

-- Shift+矢印で範囲選択
map('n', '<S-Up>', 'v<Up>', opts)
map('n', '<S-Down>', 'v<Down>', opts)
map('n', '<S-Left>', 'v<Left>', opts)
map('n', '<S-Right>', 'v<Right>', opts)
map('i', '<S-Up>', '<Esc>v<Up>', opts)
map('i', '<S-Down>', '<Esc>v<Down>', opts)
map('i', '<S-Left>', '<Esc>v<Left>', opts)
map('i', '<S-Right>', '<Esc>v<Right>', opts)
