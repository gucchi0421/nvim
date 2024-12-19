return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("neo-tree").setup({
            filesystem = {
                follow_current_file = true, -- 現在開いているファイルにフォーカス
                use_libuv_file_watcher = true,
                filtered_items = {
                    visible = true,          -- 隠しファイルを表示
                    hide_dotfiles = false,   -- ドットファイルを非表示にしない
                    hide_gitignored = false, -- Gitで無視されているファイルも表示
                },
            },
        })
    end,
}
