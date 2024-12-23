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
            local lspconfig = require("lspconfig")
            local mason_lspconfig = require("mason-lspconfig")
            local typescript = require("typescript")
            local capabilities = require("cmp_nvim_lsp").default_capabilities()

            -- 共通の on_attach 関数
            local function on_attach(_, bufnr)
                local bufmap = vim.api.nvim_buf_set_keymap
                local opts = { noremap = true, silent = true }

                -- キーマッピング
                bufmap(bufnr, "n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
                bufmap(bufnr, "n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
                bufmap(bufnr, "n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
                bufmap(bufnr, "n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
            end

            -- 共通設定
            local default_config = {
                on_attach = on_attach,
                capabilities = capabilities,
            }

            -- Masonでインストールしたサーバーを自動設定
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
                                formatting = {
                                    indent = {
                                        style = "space",
                                        size = 4,
                                    },
                                },
                                hints = {
                                    parameterNames = false,
                                },
                            },
                        },
                    }))
                end,
                ["pylsp"] = function()
                    lspconfig.pylsp.setup(vim.tbl_extend("force", default_config, {
                        settings = {
                            pylsp = {
                                plugins = {
                                    pycodestyle = {
                                        indent_size = 4,
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
                                stubs = {
                                    "wordpress",
                                    "apache",
                                    "curl",
                                    "date",
                                    "mysqli",
                                    "pdo_mysql",
                                    "standard",
                                    "xml",
                                    "json",
                                    "mbstring",
                                    "Reflection",
                                },
                                files = {
                                    maxSize = 5000000,
                                },
                            },
                        },
                    }))
                end,
            })
        end,
    },
}
