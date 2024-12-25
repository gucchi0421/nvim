-- smooth scroll to cursor
local group = vim.api.nvim_create_augroup("smooth_scroll_to_cursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function()
        -- 最後のカーソル位置を取得
        local last_pos = vim.fn.line([['"]])
        if last_pos >= 1 and last_pos <= vim.fn.line("$") then
            -- カーソルをファイルの先頭に移動
            vim.api.nvim_win_set_cursor(0, { 1, 0 })
            -- 少し遅延させてから最後のカーソル位置までスクロール
            vim.defer_fn(function()
                vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
                -- 'zz' コマンドでカーソル位置を中心にスクロール
                vim.cmd("normal! zz")
            end, 150) -- 遅延時間はミリ秒で指定
        end
    end,
})