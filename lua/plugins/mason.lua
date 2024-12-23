return {
    -- Mason本体
    {
        "williamboman/mason.nvim",
        opts = {
            ensure_installed = {
                -- 一般ツール
                "stylua",     -- Luaフォーマッタ
                "shellcheck", -- シェルスクリプト静的解析
                "shfmt",      -- シェルスクリプトフォーマッタ
                "flake8",     -- Python静的解析ツール

                -- Go関連ツール
                "golangci-lint", -- Go用リンター
                "gomodifytags",  -- Go構造体のタグ編集ツール
                "gotests",       -- Goのテストスケルトン生成
                "impl",          -- Goのインターフェース実装ジェネレータ

                -- フォーマッタ・リンター
                "prettierd",    -- Prettierフォーマッタ
                "markdownlint", -- Markdownリンター

                -- debugpyを追加
                "debugpy",
            },
        },
    },

    -- Mason-LSPconfigの設定
    {
        "williamboman/mason-lspconfig.nvim",
        opts = {
            ensure_installed = {
                -- Go
                "gopls",

                -- Python
                "pylsp", -- Python LSP (正しい名前)

                -- Web関連
                "cssls",
                "html",
                "ts_ls", -- TypeScript/JavaScript用LSP
                "eslint",
                "jsonls",
                "emmet_ls",            -- Emmet補完
                "tailwindcss",
                "vue-language-server", -- Vue.js LSP

                -- PHP
                "intelephense",
                "phpactor",

                -- その他
                "bashls",
                "yamlls",
                "dockerls",
                "graphql",
                "marksman", -- Markdown用LSP
            },
        },
    },
}
