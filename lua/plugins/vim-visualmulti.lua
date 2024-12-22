return {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
        -- マルチカーソルのキーマッピング
        vim.g.VM_maps = {
            ['Find Under'] = '<C-d>',         -- Ctrl+d で単語選択
            ['Find Subword Under'] = '<C-d>', -- Ctrl+d でさらに選択
            ['Select All'] = '<C-S-l>',       -- Ctrl+Shift+l で全選択
            ['Skip Region'] = '<C-x>',        -- Ctrl+x で現在の選択をスキップ
            ['Remove Region'] = '<C-p>',      -- Ctrl+p で現在の選択を削除
        }
        -- カスタマイズオプション
        vim.g.VM_theme = 'ocean'   -- テーマ設定
        vim.g.VM_show_warnings = 0 -- 警告を非表示
        vim.g.VM_silent_exit = 1   -- 終了時のメッセージを非表示
    end
}
