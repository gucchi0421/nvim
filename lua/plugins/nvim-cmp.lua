return {
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
        },
        opts = function(_, opts)
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            opts.snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            }

            opts.mapping = cmp.mapping.preset.insert({
                ["<CR>"] = cmp.mapping.confirm({ select = true }),
                ["<Tab>"] = cmp.mapping.select_next_item(),
                ["<S-Tab>"] = cmp.mapping.select_prev_item(),
            })

            opts.sources = cmp.config.sources({
                { name = "luasnip" },
                { name = "buffer" },
                { name = "path" },
            })
        end,
    },
}
