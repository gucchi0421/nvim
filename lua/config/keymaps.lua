-- Keymaps are automatically loaded on the VeryLazy event
local map = vim.keymap.set -- 統一した定義方法を使用
local opts = { noremap = true, silent = true }

-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>ft", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)

-- カーソル移動（インサートモード）
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)

-- ノーマルモードに戻る
map("i", "jk", "<Esc>", opts)

-- 画面分割
map("n", "ss", ":split<CR><C-w>w", opts)
map("n", "sv", ":vsplit<CR><C-w>w", opts)
map("n", "sh", "<C-w>h", opts)
map("n", "sk", "<C-w>k", opts)
map("n", "sj", "<C-w>j", opts)
map("n", "sl", "<C-w>l", opts)
map("n", "so", "<C-w>o", opts)

-- プロジェクトマネージャー
map("n", "<leader>p", "<cmd>NeovimProjectDiscover<cr>", opts)

-- 選択操作
map("n", "<S-Up>", "v<Up>", opts)
map("n", "<S-Down>", "v<Down>", opts)
map("n", "<S-Left>", "v<Left>", opts)
map("n", "<S-Right>", "v<Right>", opts)
map("i", "<S-Up>", "<Esc>v<Up>", opts)
map("i", "<S-Down>", "<Esc>v<Down>", opts)
map("i", "<S-Left>", "<Esc>v<Left>", opts)
map("i", "<S-Right>", "<Esc>v<Right>", opts)

-- カット＆コピー操作
map("n", "<C-x>", "dd", opts)      -- 通常モード: 行カット
map("v", "<C-x>", "d", opts)       -- ビジュアルモード: 選択範囲カット
map("i", "<C-x>", "<C-o>dd", opts) -- 挿入モード: 行カット

map("n", "<C-c>", "yy", opts)      -- 通常モード: 行コピー
map("v", "<C-c>", "y", opts)       -- ビジュアルモード: 選択範囲コピー
map("i", "<C-c>", "<C-o>yy", opts) -- 挿入モード: 行コピー

-- 行移動
map("n", "<A-Up>", ":m .-2<CR>==", opts)
map("n", "<A-Down>", ":m .+1<CR>==", opts)
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

-- その他の便利な操作
map("n", "<C-a>", "ggVG", opts)         -- 全選択
map("i", "<C-z>", "<C-o>u", opts)       -- 元に戻す
map("n", "<C-s>", ":w<CR>", opts)       -- 保存
map("i", "<C-s>", "<Esc>:w<CR>a", opts) -- 保存（挿入モード）

-- インデント操作
map("v", "<Tab>", ">gv", opts)   -- 右にインデント
map("v", "<S-Tab>", "<gv", opts) -- 左にインデント

-- 設定ファイルを開く
map("n", "<F1>", ":edit $MYVIMRC<CR>", opts)
