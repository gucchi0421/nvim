return {
    'akinsho/toggleterm.nvim',
    version = "*",
    config = function()
        require("toggleterm").setup {
            size = 20,
            open_mapping = [[<C-\>]], -- C-/を<C-\>に変更（より安定した動作のため）
            hide_numbers = true,
            shade_terminals = true,
            start_in_insert = true,
            insert_mappings = true,
            terminal_mappings = true,
            persist_size = true,
            direction = 'float',
            close_on_exit = true,
            float_opts = {
                border = 'curved',
                winblend = 3,
                title_pos = 'center',
                -- 以下を追加
                width = function()
                    return math.floor(vim.o.columns * 0.9)
                end,
                height = function()
                    return math.floor(vim.o.lines * 0.9)
                end,
            },
        }

        -- lazygitの設定を修正
        local Terminal = require('toggleterm.terminal').Terminal
        local lazygit = Terminal:new({
            cmd = "lazygit",
            dir = "git_dir",
            direction = "float",
            float_opts = {
                border = "curved",
            },
            on_open = function(term)
                vim.cmd("startinsert!") -- インサートモードで開始
            end,
            on_close = function(term)
                vim.cmd("checktime")  -- ターミナルが閉じた後にファイルの変更を確認
                vim.cmd("ToggleTerm") -- 真ん中のターミナル領域を閉じる
            end,
        })

        -- グローバル関数として定義
        _G.lazygit_toggle = function()
            lazygit:toggle()
        end

        -- キーマッピングを設定
        vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua lazygit_toggle()<CR>", {
            noremap = true,
            silent = true,
        })
        vim.keymap.set('t', 'Q', [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })
    end
}
