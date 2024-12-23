return {
    {
        "jose-elias-alvarez/null-ls.nvim",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function()
            local null_ls = require("null-ls")
            null_ls.setup({
                sources = {
                    null_ls.builtins.formatting.prettier.with({
                        filetypes = { "css", "scss", "less", "html", "javascript", "typescript", "jsx", "tsx" },
                    }),
                    null_ls.builtins.formatting.phpcsfixer.with({
                        filetypes = { "php" },
                    }),
                },

                on_attach = function(client, bufnr)
                    if client.supports_method("textDocument/formatting") then
                        vim.api.nvim_buf_set_keymap(
                            bufnr,
                            "n",
                            "<leader>F",
                            "<cmd>lua vim.lsp.buf.format({ async = true })<CR>",
                            { noremap = true, silent = true }
                        )
                    end
                end,
            })

            -- 保存時に自動フォーマット
            vim.api.nvim_create_autocmd("BufWritePre", {
                pattern = { "*.css", "*.scss", "*.less", "*.html", "*.js", "*.ts", "*.jsx", "*.tsx", "*.php" },
                callback = function()
                    vim.lsp.buf.format({ async = false })
                end,
            })
        end,
    },
}
