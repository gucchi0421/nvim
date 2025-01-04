-- ステータスバーの設定
vim.o.winbar =
"%#WinBarPath#%= [ POS: %{line('.')}:%{col('.')}:%3p%% ] [ LINE: %{line('$')} ] [ SIZE: %{getfsize(expand('%'))}B ] [ %{&fileencoding != '' ? &fileencoding : 'utf-8'} ] [ %{&fileformat != '' ? &fileformat : 'unix'} ]"

vim.cmd([[ highlight WinBarPath guifg=#606060 guibg=#1c1c1c ]])

vim.opt.helplang = "ja"           -- ヘルプ言語を日本語に設定
vim.opt.expandtab = true          -- タブをスペースに変換
vim.opt.autoindent = true         -- 自動インデントを有効にする
vim.opt.expandtab = true          -- タブ文字をスペースに置き換える
vim.opt.shiftwidth = 4            -- 自動インデント時のスペース数
vim.opt.tabstop = 4               -- タブ1つのスペース数
vim.opt.softtabstop = 4           -- <Tab>キーのスペース数
vim.opt.autochdir = true          -- プロジェクトルートを自動設定する
vim.opt.wrap = true               -- 行の折り返し
vim.opt.breakindent = true        -- インデントを保持したまま折り返す
vim.opt.linebreak = true          -- 単語の途中で折り返さない
vim.opt.clipboard = "unnamedplus" -- コピペを有効化
vim.opt.swapfile = false          -- スワップファイルを生成しない
vim.opt.helplang = "ja"           -- ヘルプファイルの言語は日本語
vim.opt.guicursor = "n-i:ver25"   -- フォーカスしている行を太字にする
vim.opt.termguicolors = true      -- 24ビットカラー
vim.opt.spelllang = "en,cjk"      -- 日本語のスペルチェック
vim.opt.showcmd = true            -- 入力中のコマンドを表示
