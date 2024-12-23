-- lua/plugins/nvim-cmp.lua
return {
    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                completion = {
                    autocomplete = false, -- 自動補完オフ
                },
                -- window = {
                --     documentation = false -- ドキュメントウィンドウ無効化
                -- },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                -- mapping = cmp.mapping.preset.insert({
                --     ["<CR>"] = cmp.mapping.confirm({ select = true }),
                --     ["<Tab>"] = cmp.mapping.select_next_item(),
                --     ["<S-Tab>"] = cmp.mapping.select_prev_item(),
                -- }),
                -- sources = cmp.config.sources({
                --     { name = "nvim_lsp" },
                --     { name = "luasnip" },
                --     { name = "buffer" },
                --     { name = "path" },
                -- }),
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[Snippet]",
                            buffer = "[Buffer]",
                            path = "[Path]",
                        })[entry.source.name]
                        return vim_item
                    end
                }
            })
        end,
    },
}
