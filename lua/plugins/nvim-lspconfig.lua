return {
    {
        "neovim/nvim-lspconfig",
        config = function()
            require("lspconfig").gopls.setup({
                settings = {
                    gopls = {
                        formatting = {
                            indent = {
                                style = "space",
                                size = 4,
                            },
                        },
                        hints = {
                            parameterNames = false, -- 引数のヒントを無効化
                        },
                    },
                },
            })

            require("lspconfig").pylsp.setup({
                settings = {
                    pylsp = {
                        plugins = {
                            pycodestyle = {
                                indent_size = 4,
                            },
                        },
                    },
                },
            })
        end,
    },
}
