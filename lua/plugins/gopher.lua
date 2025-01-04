return {
    "olexsmir/gopher.nvim",
    ft = "go",
    dependencies = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
        "mfussenegger/nvim-dap",
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
                transform = "snakecase",
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
        map("n", "<leader>cgt", "<cmd>GoTestAdd<CR>", { desc = "Test current function" }) -- 修正
        map("n", "<leader>cga", "<cmd>GoTestsAll<CR>", { desc = "Generate all tests" })
        map("n", "<leader>cge", "<cmd>GoTestsExp<CR>", { desc = "Test exported funcs" })

        -- タグ関連
        map("n", "<leader>cgj", "<cmd>GoTagAdd json<CR>", { desc = "Add json tags" })
        map("n", "<leader>cgr", "<cmd>GoTagRm json<CR>", { desc = "Remove json tags" })

        -- エラーハンドリング
        map("n", "<leader>cgi", "<cmd>GoIfErr<CR>", { desc = "Generate if err" })

        -- インターフェース実装
        map("n", "<leader>cgm", "<cmd>GoImpl ", { desc = "Implement interface" })

        -- その他
        map("n", "<leader>cgd", "<cmd>GoMod tidy<CR>", { desc = "Go mod tidy" })
        map("n", "<leader>cgg", "<cmd>GoGenerate<CR>", { desc = "Go generate" })
        map("n", "<leader>cgc", "<cmd>GoCmt<CR>", { desc = "Generate comment" })
    end,
    build = ":TSInstall go",
}
