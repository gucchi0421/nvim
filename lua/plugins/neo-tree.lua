return {
    "nvim-neo-tree/neo-tree.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
        require("neo-tree").setup({
            close_if_last_window = true,
            popup_border_style = "rounded",
            enable_git_status = true,
            enable_diagnostics = true,
            event_handlers = {
                {
                    event = "file_opened",
                    handler = function()
                        -- return require("neo-tree").close_all()
                    end
                },
                {
                    event = "file_added",
                    handler = function(file_path)
                        -- ファイルが追加されたときに明示的に更新
                        require("neo-tree.sources.manager").refresh("filesystem")
                    end
                },
            },
            -- ファイル監視を有効化
            use_libuv_file_watcher = true,
            filesystem = {
                filtered_items = {
                    visible = true,
                    hide_dotfiles = false,
                    hide_gitignored = false,
                },
                follow_current_file = {
                    enabled = true,
                    leave_dirs_open = true,
                },
                group_empty_dirs = false,
                hijack_netrw_behavior = "open_current",
                -- ファイルシステムの監視設定
                scan_mode = "deep",
                use_watchfile = true,
                watch_dir = true,
                -- 更新間隔を短く
                watch_timeout = 100,
            },
            window = {
                position = "left",
                width = 35,
            },
            source_selector = {
                winbar = true,
                content_layout = "center",
                sources = {
                    { source = "filesystem" },
                    { source = "buffers" },
                    { source = "git_status" },
                },
            },
        })

        -- gopherプラグインのテスト生成後に明示的に更新するための設定
        vim.api.nvim_create_autocmd("User", {
            pattern = "GoTestAdd",
            callback = function()
                vim.defer_fn(function()
                    require("neo-tree.sources.manager").refresh("filesystem")
                end, 100)
            end
        })
    end,
}
