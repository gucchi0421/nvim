return {
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "williamboman/mason.nvim",
            "williamboman/mason-lspconfig.nvim",
            "jose-elias-alvarez/typescript.nvim",
        },
        config = function()
            require("mason").setup({
                ui = {
                    icons = {
                        package_installed = "✓",
                        package_pending = "➜",
                        package_uninstalled = "✗"
                    }
                }
            })

            require("mason-lspconfig").setup({
                ensure_installed = {
                    "gopls",
                    "pylsp",
                    "ts_ls",
                    "intelephense",
                    "cssls"
                }
            })

            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local typescript = require("typescript")

            local capabilities = vim.tbl_deep_extend(
                "force",
                vim.lsp.protocol.make_client_capabilities(),
                require("cmp_nvim_lsp").default_capabilities()
            )

            local function on_attach(_, bufnr)
                local bufmap = vim.api.nvim_buf_set_keymap
                local opts = { noremap = true, silent = true }

                bufmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                bufmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                bufmap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                bufmap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            end

            local default_config = {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            mason_lspconfig.setup_handlers({
                function(server_name)
                    lspconfig[server_name].setup(default_config)
                end,
                ["ts_ls"] = function()
                    typescript.setup({
                        server = vim.tbl_extend("force", default_config, {
                            settings = {
                                typescript = {
                                    format = {
                                        indentSize = 2,
                                        tabSize = 2,
                                    },
                                },
                            },
                        }),
                    })
                end,
                ["gopls"] = function()
                    lspconfig.gopls.setup(vim.tbl_extend("force", default_config, {
                        settings = {
                            gopls = {
                                analyses = {
                                    unusedparams = true,   -- 使用されていないパラメータを検出。
                                    shadow = true,         -- 変数のシャドウイング（上書き）を検出。
                                    fieldalignment = true, -- フィールドのアライメントの最適化を検出。
                                    nilness = true,        -- nil値の不適切な使用を検出。
                                    useany = true,         -- `interface{}`の使用を警告。
                                    unusedwrite = true,    -- 使用されていない書き込みを検出。
                                    unusedvariable = true, -- 使用されていない変数を検出。
                                    undeclaredname = true, -- 宣言されていない名前を警告。
                                    unreachable = true,    -- 到達不能なコードを検出。
                                },
                                ui = {
                                    completion = {
                                        snippets = "top",           -- 補完リストにスニペットを上位表示。
                                        instantTextDocument = true, -- ドキュメントを即時表示。
                                        matcher = "fuzzy",          -- 補完候補の曖昧一致を使用。
                                        mocksPreselected = true,    -- モックの補完候補を事前選択。
                                    },
                                    diagnostic = {
                                        annotations = true,         -- 診断に注釈を表示。
                                        diagnosticsDelay = "200ms", -- 診断の遅延を200msに設定。
                                    },
                                    navigation = {
                                        importShortcut = "Definition", -- 定義ショートカットをインポートする。
                                        symbolMatcher = "fuzzy",       -- シンボル検索で曖昧一致を使用。
                                        symbolStyle = "Dynamic",       -- シンボルスタイルを動的に設定。
                                    },
                                },
                                staticcheck = true,                       -- 高機能なGoの静的解析ツール
                                usePlaceholders = true,                   -- プレースホルダー（補完時に埋め込むテンプレート）を有効化
                                buildFlags = { "-tags=integration,e2e" }, -- goplsに渡すビルドフラグを設定
                                gofumpt = true,
                                codelenses = {
                                    gc_details = true,         -- ガベージコレクションの詳細。
                                    generate = true,           -- コード生成。
                                    regenerate_cgo = true,     -- cgoコードの再生成。
                                    test = true,               -- テスト実行。
                                    tidy = true,               -- モジュールの整合性チェック。
                                    upgrade_dependency = true, -- 依存関係の更新。
                                    vendor = true,             -- ベンダリング。
                                },
                                hints = {
                                    assignVariableTypes = true,    -- 変数割り当ての型を表示。
                                    compositeLiteralFields = true, -- リテラルフィールドの名前を表示。
                                    compositeLiteralTypes = true,  -- リテラル型を表示。
                                    constantValues = true,         -- 定数の値を表示。
                                    functionTypeParameters = true, -- 関数の型パラメータを表示。
                                    parameterNames = true,         -- パラメータ名を表示。
                                    rangeVariableTypes = true,     -- 範囲変数の型を表示。
                                },
                                semanticTokens = true,
                                experimentalPostfixCompletions = true,
                                experimentalWorkspaceModule = true,
                                experimentalTemplateSupport = true,
                                experimentalDiagnosticsDelay = "200ms",
                                completeUnimported = true,
                                deepCompletion = true,
                                fuzzyMatching = true,
                                matcher = "Fuzzy",
                                symbolMatcher = "fuzzy",
                                symbolStyle = "Dynamic",
                                linkTarget = "pkg.go.dev",
                                vulncheck = "Imports"
                            }
                        },
                        flags = {
                            debounce_text_changes = 150,
                        },
                        capabilities = vim.tbl_deep_extend("force", capabilities, {
                            textDocument = {
                                completion = {
                                    completionItem = {
                                        snippetSupport = true,
                                        preselectSupport = true,
                                        insertReplaceSupport = true,
                                        labelDetailsSupport = true,
                                        deprecatedSupport = true,
                                        commitCharactersSupport = true,
                                        documentationFormat = { "markdown", "plaintext" },
                                        insertTextModeSupport = {
                                            valueSet = { 1, 2 }
                                        }
                                    }
                                }
                            }
                        })
                    }))
                end,
                ["pylsp"] = function()
                    lspconfig.pylsp.setup(vim.tbl_extend("force", default_config, {
                        settings = {
                            pylsp = {
                                plugins = {
                                    pycodestyle = {
                                        max_line_length = 88,
                                    },
                                    flake8 = {
                                        enabled = true,
                                        maxLineLength = 88,
                                    },
                                    pylint = {
                                        enabled = true,
                                        args = { "--max-line-length=88", "--disable=C0111" },
                                    },
                                    pyls_mypy = {
                                        enabled = true,
                                        live_mode = true,
                                        strict = true,
                                    },
                                },
                                completion = {
                                    cr_behavior = "newline",
                                },
                                analysis = {
                                    typeCheckingMode = "strict",
                                    useLibraryCodeForTypes = true,
                                },
                            },
                        },
                    }))
                end,
                ["intelephense"] = function()
                    lspconfig.intelephense.setup(vim.tbl_extend("force", default_config, {
                        settings = {
                            intelephense = {
                                -- 標準ライブラリやフレームワークのスタブ
                                stubs = {
                                    "wordpress",    -- WordPress関連
                                    "apache",       -- Apache関連
                                    "curl",         -- cURLライブラリ
                                    "date",         -- 日付操作
                                    "mysqli",       -- MySQLi
                                    "pdo_mysql",    -- PDO (MySQL)
                                    "standard",     -- PHP標準ライブラリ
                                    "xml",          -- XML操作
                                    "json",         -- JSON操作
                                    "mbstring",     -- マルチバイト文字列
                                    "Reflection",   -- リフレクションAPI
                                    "composer",     -- Composerサポート
                                    "PDO",          -- PDOサポート
                                    "Core",         -- PHPのコア機能
                                    "SPL",          -- SPL (Standard PHP Library)
                                    "pcntl",        -- プロセス制御関連
                                    "superglobals", -- スーパーグローバル変数補完
                                },
                                -- ファイル制限の調整
                                files = {
                                    maxSize = 10000000,       -- 10MBに拡大
                                    exclude = {
                                        "**/vendor/**",       -- Composerの依存ディレクトリを除外
                                        "**/node_modules/**", -- Node.jsの依存を除外
                                        "**/.git/**",         -- Gitディレクトリを除外
                                    },
                                },
                                -- 診断レベルを強化
                                diagnostics = {
                                    enable = true,                -- 診断機能を有効化
                                    undefinedTypes = true,        -- 未定義型を警告
                                    undefinedFunctions = true,    -- 未定義関数を警告
                                    undefinedConstants = true,    -- 未定義定数を警告
                                    undefinedVariables = true,    -- 未定義変数を警告
                                    unusedVariables = true,       -- 未使用変数を警告
                                    parameterTypeMismatch = true, -- 引数の型ミスマッチを警告
                                    returnTypeMismatch = true,    -- 戻り値の型ミスマッチを警告
                                },
                                -- PHP環境設定
                                environment = {
                                    phpVersion = "8.1", -- 使用するPHPバージョン
                                },
                                -- 補完のカスタマイズ
                                completion = {
                                    fullyQualifyGlobalConstantsAndFunctions = true, -- 完全修飾名で補完
                                    triggerParameterHints = true,                   -- 引数ヒントをトリガー
                                },
                                -- フォーマットの有効化
                                format = {
                                    enable = true, -- LSPによるフォーマットを有効化
                                },
                            },
                        },
                        flags = {
                            debounce_text_changes = 150, -- テキスト変更のデバウンス時間
                        },
                    }))
                end,
                ["html"] = function()
                    lspconfig.html.setup(vim.tbl_extend("force", default_config, {
                        settings = {
                            html = {
                                format = {
                                    enable = true, -- 自動フォーマットを有効化
                                    wrapLineLength = 120,
                                    preserveNewLines = true,
                                },
                                hover = {
                                    documentation = true,
                                    references = true,
                                },
                                validate = {
                                    styles = true,
                                    scripts = true,
                                },
                            },
                        },
                        flags = {
                            debounce_text_changes = 150,
                        },
                    }))
                end,
                ["cssls"] = function()
                    lspconfig.cssls.setup(vim.tbl_extend("force", default_config, {
                        settings = {
                            css = {
                                lint = {
                                    unknownAtRules = "ignore", -- 未知のルールを無視（tailwindなど独自ルールに対応）
                                },
                                completion = {
                                    completePropertyWithSemicolon = true, -- プロパティ補完時にセミコロンを追加
                                    completePropertyWithComma = true,     -- プロパティ補完時にカンマを追加
                                },
                                validate = true,                          -- CSSバリデーションを有効化
                            },
                            scss = {
                                validate = true, -- SCSSバリデーションを有効化
                            },
                        },
                        capabilities = vim.tbl_deep_extend("force", capabilities, {
                            textDocument = {
                                completion = {
                                    completionItem = {
                                        snippetSupport = true, -- スニペット補完を有効化
                                        preselectSupport = true,
                                        insertReplaceSupport = true,
                                        labelDetailsSupport = true,
                                        commitCharactersSupport = true,
                                        documentationFormat = { "markdown", "plaintext" },
                                    },
                                },
                            },
                        }),
                        flags = {
                            debounce_text_changes = 150,
                        },
                    }))
                end,
            })
            -- LSPの自動起動
            vim.api.nvim_create_autocmd('FileType', {
                pattern = { 'go', 'python', 'typescript', 'php', 'css', 'scss' },
                callback = function()
                    vim.cmd('LspStart')
                end,
            })
        end,
    },
}
