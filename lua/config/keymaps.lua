-- Keymaps are automatically loaded on the VeryLazy event
local map = vim.keymap.set
local opts = { noremap = true, silent = true }

---------------------------
-- 基本的なキーマッピング --
---------------------------
-- モード切り替え
map("i", "jj", "<Esc>", opts) -- インサートモードから抜ける
map("i", "ｊｊ", "<Esc>", opts) -- インサートモードから抜ける

-- ファイル操作
map("n", "<C-s>", ":w<CR>", opts)            -- 保存
map("n", "<F1>", ":edit $MYVIMRC<CR>", opts) -- 設定ファイルを開く

------------------------
-- カーソル・移動操作 --
------------------------
-- インサートモードでのカーソル移動
map("i", "<C-k>", "<Up>", opts)
map("i", "<C-j>", "<Down>", opts)
map("i", "<C-h>", "<Left>", opts)
map("i", "<C-l>", "<Right>", opts)

-- 行移動
map("n", "<A-Up>", ":m .-2<CR>==", opts)
map("n", "<A-Down>", ":m .+1<CR>==", opts)
map("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", opts)
map("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", opts)
map("v", "<A-Up>", ":m '<-2<CR>gv=gv", opts)
map("v", "<A-Down>", ":m '>+1<CR>gv=gv", opts)

------------------------
-- テキスト編集操作 --
------------------------
-- インデント
map("v", "<TAB>", ">gv", opts)   -- 選択範囲を右にインデント
map("v", "<S-TAB>", "<gv", opts) -- 選択範囲を左にインデント

-- 選択操作
map("n", "<C-a>", "ggVG", opts) -- 全選択
map("n", "<S-Up>", "v<Up>", opts)
map("n", "<S-Down>", "v<Down>", opts)
map("n", "<S-Left>", "v<Left>", opts)
map("n", "<S-Right>", "v<Right>", opts)
map("i", "<S-Up>", "<Esc>v<Up>", opts)
map("i", "<S-Down>", "<Esc>v<Down>", opts)
map("i", "<S-Left>", "<Esc>v<Left>", opts)
map("i", "<S-Right>", "<Esc>v<Right>", opts)

-- 編集操作
map("v", "<C-d>", "d<Esc>i", opts) -- 選択範囲を削除してインサートモードへ

-- コピー&ペースト
map("v", "<C-x>", "d<Esc>", opts)    -- 選択範囲カット
map("v", "<C-c>", "y<Esc>", opts)    -- 選択範囲コピー
map("i", "<C-x>", "<Esc>dd$i", opts) -- 行カット
map("i", "<C-c>", "<Esc>yy$i", opts) -- 行コピー
map("n", "<C-x>", "dd$i", opts)      -- 行カット
map("n", "<C-c>", "yy$i", opts)      -- 行コピー
map("n", "<C-v>", "p<Esc>i", opts)   -- ペースト
map("v", "<C-v>", "p<Esc>i", opts)   -- ペースト
map("i", "<C-v>", "<Esc>pi", opts)   -- ペースト

-- 元に戻す/やり直し
map("i", "<C-z>", "<C-o>u", opts)     -- 元に戻す
map("i", "<C-b>", "<C-o><C-r>", opts) -- やり直し
map("n", "<C-b>", "<C-r>", opts)      -- やり直し

------------------------
-- ウィンドウ操作 --
------------------------
-- 画面分割
map("n", "ss", ":split<CR><C-w>w", opts)  -- 水平分割
map("n", "sv", ":vsplit<CR><C-w>w", opts) -- 垂直分割
map("n", "sh", "<C-w>h", opts)            -- 左のウィンドウへ
map("n", "sk", "<C-w>k", opts)            -- 上のウィンドウへ
map("n", "sj", "<C-w>j", opts)            -- 下のウィンドウへ
map("n", "sl", "<C-w>l", opts)            -- 右のウィンドウへ
map("n", "so", ":close<CR>", opts)        -- ウィンドウを閉じる

------------------------
-- プラグイン操作 --
------------------------
-- Telescope
map("n", "<leader>ff", "<cmd>Telescope find_files<cr>", opts)
map("n", "<leader>fg", "<cmd>Telescope live_grep<cr>", opts)
map("n", "<leader>ft", "<cmd>Telescope current_buffer_fuzzy_find<cr>", opts)

-- プロジェクトマネージャー
map("n", "<leader>p", "<cmd>NeovimProjectDiscover<cr>", opts)
