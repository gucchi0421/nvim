-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.expandtab = true   -- タブをスペースに変換
vim.opt.shiftwidth = 4     -- 自動インデント時のスペース数
vim.opt.tabstop = 4        -- タブ1つのスペース数
vim.opt.softtabstop = 4    -- <Tab>キーのスペース数
vim.opt.autochdir = true   -- プロジェクトルートを自動設定する
vim.opt.wrap = true        -- 行の折り返し
vim.opt.breakindent = true -- インデントを保持したまま折り返す
vim.opt.linebreak = true   -- 単語の途中で折り返さない
