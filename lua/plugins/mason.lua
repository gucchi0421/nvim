return {
    -- Mason本体: ツールインストールマネージャ
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- 一般ツール
                "stylua",        -- Luaコードフォーマッタ
                "shellcheck",    -- シェルスクリプト用静的解析ツール
                "shfmt",         -- シェルスクリプト用フォーマッタ
                "flake8",        -- Python用静的解析ツール
                "black",         -- Python用フォーマッタ
                "isort",         -- Pythonインポート順序整理ツール
                "mypy",          -- Python型チェックツール
                "prettier",      -- JavaScript/TypeScript/HTML/CSS用フォーマッタ
                "golangci-lint", -- Go用静的解析ツール（リンター）
                "gomodifytags",  -- Go構造体のタグ編集ツール
                "gotests",       -- Goテストスケルトン生成ツール
                "impl",          -- Goのインターフェース実装ジェネレータ
                "prettierd",     -- Prettierデーモン（軽量で高速なフォーマッタ）
                "markdownlint",  -- Markdownファイル用リンター
                "phpstan",       -- PHPの静的解析ツール
                "phpcs",         -- PHPコード規約チェックツール
                "debugpy",       -- Python用デバッガ
                "jdtls"
            },
        },
    },

    -- Mason-LSPconfig: MasonとLSPconfigを連携させるプラグイン
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                "gopls",                       -- Go用LSPサーバー
                "pylsp",                       -- Python用LSPサーバー
                "cssls",                       -- CSS用LSPサーバー
                "html",                        -- HTML用LSPサーバー
                "ts_ls",                       -- TypeScript/JavaScript用LSPサーバー
                "eslint",                      -- ESLint統合
                "jsonls",                      -- JSON用LSPサーバー
                "emmet_ls",                    -- Emmet補完用LSPサーバー
                "tailwindcss-language-server", -- Tailwind CSS用LSPサーバー（コメントアウト例）
                "vue-language-server",         -- Vue.js用LSPサーバー
                "intelephense",                -- PHP用LSPサーバー（一般的な補完・診断）
                "phpactor",                    -- PHP用高度なリファクタリングLSPサーバー
                "bashls",                      -- Bash用LSPサーバー
                "yamlls",                      -- YAML用LSPサーバー
                "dockerls",                    -- Dockerファイル用LSPサーバー
                "graphql",                     -- GraphQL用LSPサーバー
                "marksman",                    -- Markdown用LSPサーバー
                "jdtls"
            },
        },
    },
}
