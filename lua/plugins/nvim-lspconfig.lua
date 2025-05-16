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
            package_uninstalled = "✗",
          },
        },
      })

      require("mason-lspconfig").setup({
        ensure_installed = {
          "gopls",
          "pylsp",
          "ts_ls",
          "intelephense",
          "html",
          "cssls",
          "dockerls",
          "jdtls",
          "lua_ls",
          "emmet_ls",
          "protols",
        },
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
            capabilities = capabilities,
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
        ["emmet_ls"] = function()
          lspconfig.emmet_ls.setup(vim.tbl_extend("force", default_config, {
            settings = {
              emmet_ls = {
                capabilities = capabilities,
                filetypes = { "html", "typescriptreact", "javascriptreact", "css", "sass", "scss", "less", "blade" },
              },
            },
          }))
        end,
        ["gopls"] = function()
          lspconfig.gopls.setup(vim.tbl_extend("force", default_config, {
            settings = {
              gopls = {
                analyses = {
                  unusedparams = true, -- 使用されていないパラメータを検出。
                  shadow = true, -- 変数のシャドウイング（上書き）を検出。
                  fieldalignment = false, -- フィールドのアライメントの最適化を無効化
                  nilness = false, -- nil値の不適切な使用を無効化
                  useany = true, -- `interface{}`の使用を警告。
                  unusedwrite = true, -- 使用されていない書き込みを検出。
                  unusedvariable = true, -- 使用されていない変数を検出。
                  undeclaredname = true, -- 宣言されていない名前を警告。
                  unreachable = true, -- 到達不能なコードを検出。
                },
                ui = {
                  completion = {
                    instantTextDocument = true, -- ドキュメントを即時表示。
                    mocksPreselected = true, -- モックの補完候補を事前選択。
                    snippets = "inline", -- スニペットをインラインで表示。
                    matcher = "caseSensitiveFuzzy", -- 大文字小文字を区別した曖昧一致。
                    fields = "first", -- フィールドを補完リストの上位に表示。
                  },
                  diagnostic = {
                    annotations = true, -- 診断に注釈を表示。
                    diagnosticsDelay = "500ms", -- 診断の遅延を200msに設定。
                  },
                  navigation = {
                    importShortcut = "Definition", -- 定義ショートカットをインポートする。
                    symbolMatcher = "fuzzy", -- シンボル検索で曖昧一致を使用。
                    symbolStyle = "Dynamic", -- シンボルスタイルを動的に設定。
                  },
                },
                staticcheck = true, -- 高機能なGoの静的解析ツール
                usePlaceholders = true, -- プレースホルダー（補完時に埋め込むテンプレート）を有効化
                buildFlags = {}, -- 空に設定
                gofumpt = true,
                codelenses = {
                  "bufls",
                  gc_details = true, -- ガベージコレクションの詳細。
                  generate = true, -- コード生成。
                  regenerate_cgo = true, -- cgoコードの再生成。
                  test = true, -- テスト実行。
                  tidy = true, -- モジュールの整合性チェック。
                  upgrade_dependency = true, -- 依存関係の更新。
                  vendor = true, -- ベンダリング。
                },
                hints = {
                  assignVariableTypes = false, -- 変数割り当ての型を表示しない
                  compositeLiteralFields = false, -- リテラルフィールドの名前を表示しない
                  compositeLiteralTypes = false, -- リテラル型を表示しない
                  constantValues = false, -- 定数の値を表示しない
                  parameterNames = true, -- パラメータ名は表示
                  rangeVariableTypes = false, -- 範囲変数の型を表示しない
                },
                semanticTokens = true,
                experimentalPostfixCompletions = false,
                experimentalWorkspaceModule = false,
                experimentalTemplateSupport = false,
                experimentalDiagnosticsDelay = "200ms",
                completeUnimported = true,
                deepCompletion = false,
                fuzzyMatching = true,
                matcher = "Fuzzy",
                symbolMatcher = "fuzzy",
                symbolStyle = "Dynamic",
                linkTarget = "pkg.go.dev",
                vulncheck = "Imports",
              },
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
                      valueSet = { 1, 2 },
                    },
                  },
                },
              },
            }),
          }))
        end,
        ["pylsp"] = function()
          lspconfig.pylsp.setup(vim.tbl_extend("force", default_config, {
            settings = {
              pylsp = {
                plugins = {
                  pylsp_mypy = {
                    enabled = true,
                    live_mode = true, -- 保存前にチェック
                    strict = true, -- 厳格な型チェック
                  },
                  pycodestyle = {
                    enabled = true,
                    maxLineLength = 120, -- 長い行の設定を適用
                  },
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
                  "wordpress", -- WordPress関連
                  "apache", -- Apache関連
                  "curl", -- cURLライブラリ
                  "date", -- 日付操作
                  "mysqli", -- MySQLi
                  "pdo_mysql", -- PDO (MySQL)
                  "standard", -- PHP標準ライブラリ
                  "xml", -- XML操作
                  "json", -- JSON操作
                  "mbstring", -- マルチバイト文字列
                  "Reflection", -- リフレクションAPI
                  "composer", -- Composerサポート
                  "PDO", -- PDOサポート
                  "bufls",
                  "Core", -- PHPのコア機能
                  "SPL", -- SPL (Standard PHP Library)
                  "pcntl", -- プロセス制御関連
                  "superglobals", -- スーパーグローバル変数補完
                  "laravel", -- Laravel関連
                },
                -- ファイル制限の調整
                files = {
                  maxSize = 10000000, -- 10MBに拡大
                  exclude = {
                    "**/.git/**", -- Gitディレクトリを除外
                  },
                },
                -- 診断レベルを強化
                diagnostics = {
                  enable = true, -- 診断機能を有効化
                  parameterTypeMismatch = true, -- 引数の型ミスマッチを警告
                  returnTypeMismatch = true, -- 戻り値の型ミスマッチを警告
                },
                -- PHP環境設定
                environment = {
                  phpVersion = "8.2", -- 使用するPHPバージョン
                },
                -- 補完のカスタマイズ
                completion = {
                  fullyQualifyGlobalConstantsAndFunctions = true, -- 完全修飾名で補完
                  triggerParameterHints = true, -- 引数ヒントをトリガー
                },
                includePaths = {
                  "./_ide_helper.php", -- `ide-helper` ファイルを含める
                  "./_ide_helper_models.php", -- モデル補完ファイルを含める
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
            filetypes = { "html", "blade" },
            settings = {
              html = {
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
                  completePropertyWithComma = true, -- プロパティ補完時にカンマを追加
                },
                validate = true, -- CSSバリデーションを有効化
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
        ["dockerls"] = function()
          lspconfig.dockerls.setup(vim.tbl_extend("force", default_config, {
            settings = {
              docker = {
                languageserver = {
                  formatter = {
                    ignoreMultilineInstructions = true,
                  },
                },
              },
            },
          }))
        end,
        ["jdtls"] = function()
          lspconfig.jdtls.setup({ cmd = { "jdtls" } })
        end,
        ["protols"] = function()
          lspconfig.protols.setup({})
        end,
        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            settings = {
              Lua = {
                runtime = {
                  version = "LuaJIT",
                  pathStrict = true,
                  path = { "?.lua", "?/init.lua" },
                },
                workspace = {
                  checkThirdParty = "Disable",
                },
              },
            },
          })
        end,
      })
      lspconfig.protols.setup({})
      -- LSPの自動起動
      vim.api.nvim_create_autocmd("FileType", {
        pattern = {
          "go",
          "python",
          "javascript",
          "typescript",
          "javascriptreact",
          "typescriptreact",
          "php",
          "css",
          "scss",
          "html",
          "dockerfile",
          "jdtls",
          "java",
          "kotlin",
          "rust",
          "lua",
          "blade",
          "proto",
        },
        callback = function()
          vim.cmd("LspStart")
        end,
      })
    end,
  },
}
