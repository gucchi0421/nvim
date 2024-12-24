return {
    "vim-test/vim-test",
    config = function()
        -- 基本設定
        vim.g['test#strategy'] = "neovim"
        vim.g['test#go#gotest#options'] = '-v'

        -- テスト結果を右側に表示
        vim.g['test#neovim#term_position'] = "vert botright"

        -- ファイル内の全テスト実行
        vim.keymap.set("n", "<leader>tf", ":TestFile<CR>")

        -- カーソル位置のテスト実行
        vim.keymap.set("n", "<leader>tt", ":TestNearest<CR>")

        -- 最後に実行したテストを再実行
        vim.keymap.set("n", "<leader>tl", ":TestLast<CR>")
    end
}
