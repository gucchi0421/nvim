return {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
    },
    config = function()
        require("gopher").setup({
            commands = {
                go = "go",
                gomodifytags = "gomodifytags",
                gotests = "gotests", -- Goのテスト生成ツール
                impl = "impl",
                iferr = "iferr",
            },
            log = {
                level = "warn",     -- ログレベルを文字列に変更
            },
            gotests = {             -- gotestsの設定
                template_dir = "",  -- カスタムテンプレートのディレクトリ
                template_name = "", -- テンプレート名（省略可能）
            },
            gotag = {               -- gomodifytagsのタグ設定
                options = {         -- タグ生成時のオプション
                    json = true,    -- JSONタグを自動追加
                    xml = false,    -- XMLタグは不要ならfalse
                },
            },
        })

        -- 依存関係をインストール
        local packages = {
            "github.com/fatih/gomodifytags@latest",
            "github.com/cweill/gotests/gotests@latest",
            "github.com/josharian/impl@latest",
            "github.com/koron/iferr@latest",
        }

        for _, pkg in ipairs(packages) do
            vim.fn.system({ "go", "install", pkg })
        end

        -- キーバインド
        local map = vim.keymap.set

        -- テスト関連
        map("n", "<space>got", "<cmd>GoTestAdd<CR>", { desc = "Test current function" }) -- 修正
        map("n", "<space>goa", "<cmd>GoTestsAll<CR>", { desc = "Generate all tests" })
        map("n", "<space>goe", "<cmd>GoTestsExp<CR>", { desc = "Test exported funcs" })

        -- タグ関連
        map("n", "<space>goj", "<cmd>GoTagAdd json<CR>", { desc = "Add json tags" })
        map("n", "<space>gor", "<cmd>GoTagRm json<CR>", { desc = "Remove json tags" })

        -- エラーハンドリング
        map("n", "<space>goi", "<cmd>GoIfErr<CR>", { desc = "Generate if err" })

        -- インターフェース実装
        map("n", "<space>gom", "<cmd>GoImpl ", { desc = "Implement interface" })

        -- その他
        map("n", "<space>god", "<cmd>GoMod tidy<CR>", { desc = "Go mod tidy" })
        map("n", "<space>goc", "<cmd>GoCmt<CR>", { desc = "Generate comment" })
    end,
    build = ":TSInstall go",
}
