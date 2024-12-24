return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        local toggleterm = require("toggleterm")

        -- 基本設定
        toggleterm.setup({
            size = 20,
            open_mapping = [[<C-\>]],                      -- C-/をC-\に変更
            hide_numbers = true,                           -- ターミナルバッファで行番号を非表示
            shade_terminals = true,                        -- 背景を暗く
            start_in_insert = true,                        -- 挿入モードで開始
            insert_mappings = true,                        -- 挿入モードでのキーマッピングを有効
            terminal_mappings = true,                      -- ターミナルモードでのキーマッピングを有効
            persist_size = true,                           -- サイズを記憶
            close_on_exit = true,                          -- 終了時にターミナルを閉じる
            direction = 'float',                           -- フロート表示
            float_opts = {
                border = 'curved',                         -- カーブ型の枠線
                winblend = 3,                              -- 背景透過
                title_pos = 'center',                      -- タイトルの位置
                width = function()
                    return math.floor(vim.o.columns * 0.9) -- 画面幅の90%
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.9) -- 画面高さの90%
                end,
            },
        })

        -- lazygit用のターミナル設定
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",     -- コマンド
            dir = "git_dir",     -- 実行ディレクトリ
            direction = "float", -- フロート表示
            float_opts = {
                border = "curved",
            },
            on_open = function()
                vim.cmd("startinsert!") -- 挿入モードで開始
            end,
            on_close = function()
                vim.cmd("checktime") -- ファイルの変更を確認
            end,
        })

        -- lazygitをトグルする関数
        _G.lazygit_toggle = function()
            lazygit:toggle()
        end

        -- キーマッピング設定
        vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua lazygit_toggle()<CR>", {
            noremap = true,
            silent = true,
        })

        -- ターミナルを閉じるためのキー設定 (Qキー)
        vim.keymap.set('t', 'Q', [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })
    end
}
