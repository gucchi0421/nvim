-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- スペースを使う設定
vim.opt.expandtab = true -- タブをスペースに変換
vim.opt.shiftwidth = 4   -- 自動インデント時のスペース数
vim.opt.tabstop = 4      -- タブ1つのスペース数
vim.opt.softtabstop = 4  -- <Tab>キーのスペース数
vim.opt.autochdir = true -- プロジェクトルートを自動設定する
