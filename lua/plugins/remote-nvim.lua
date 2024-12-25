local ssh_config = {
    ssh_binary = "ssh",
    scp_binary = "scp",
    ssh_config_file_paths = { "$HOME/.ssh/config" },
    ssh_prompts = {
        {
            match = "Enter passphrase for key",
            type = "secret",
            value_type = "static",
            value = "",
        },
        {
            match = "password:",
            type = "secret",
            value_type = "static",
            value = "",
        },
        {
            match = "continue connecting (yes/no/[fingerprint])?",
            type = "plain",
            value_type = "static",
            value = "",
        },
    },
}

return {
    "amitds1997/remote-nvim.nvim",
    version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "MunifTanjim/nui.nvim",
        "nvim-telescope/telescope.nvim",
    },
    config = function()
        -- プラグインの基本設定
        require("remote-nvim").setup({
            ssh = ssh_config,
        })

        -- キーマッピングの設定
        local keymap = vim.keymap.set
        local opts = { noremap = true, silent = true }

        -- Remote commands
        keymap("n", "<leader>rs", ":RemoteStart<CR>", opts) -- Start remote session
        keymap("n", "<leader>rq", ":RemoteStop<CR>", opts) -- Stop remote session
        keymap("n", "<leader>ri", ":RemoteInfo<CR>", opts) -- Show session info
        keymap("n", "<leader>rc", ":RemoteCleanup<CR>", opts) -- Cleanup remote setup
        keymap("n", "<leader>rd", ":RemoteConfigDel<CR>", opts) -- Delete old records
        keymap("n", "<leader>rl", ":RemoteLog<CR>", opts) -- Open log file
    end,
}

-- :RemoteStart
-- リモートインスタンスに接続する。リモートneovimサーバーがすでに実行されている場合、ユーザーはローカルクライアントを起動できる
--
-- :RemoteStop
-- Neovimサーバーの実行を停止し、セッションを閉じる
--
-- :RemoteInfo
-- 現在の Neovim 実行で作成されたセッションに関する情報を取得する．進行状況ビューアーを開く
-- :RemoteCleanup
-- リモートインスタンスからワークスペースおよびリモートneovimセットアップ全体を削除する．また，リモートリソースの構成をクリーンアップする．
--
-- :RemoteConfigDel
-- 保存されたセッションレコードから、存在しなくなったリモートインスタンスのレコードを削除する．
--
-- :RemoteLog
-- プラグインのログファイルを開く．エラーが出たらここ見れば大体わかる．
--
-- :RemoteInfo
-- 接続に関する情報などが表示される．
