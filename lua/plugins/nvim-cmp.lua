return {
    -- { "coc.nvim",                             enabled = false, },
    -- { "deoplete.nvim",                        enabled = false, },
    { "saghen/blink.cmp",                     enabled = false },
    { "kristijanhusak/vim-dadbod-completion", enabled = false },
    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-emoji",
            "MeanderingProgrammer/render-markdown.nvim",
            "saghen/blink.cmp",
        },
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")
            local map = cmp.mapping

            cmp.setup({
                debug = true,
                window = {
                    completion = cmp.config.window.bordered(),
                    documentation = cmp.config.window.bordered(),
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "nvim_lsp",        priority = 1000 },
                    { name = "luasnip",         priority = 900 },
                    { name = "buffer",          priority = 800 },
                    { name = "path",            priority = 700 },
                    { name = "emoji",           priority = 600 },
                    { name = "render-markdown", priority = 500 },
                },
                formatting = {
                    format = function(entry, vim_item)
                        print("Source Name: ", entry.source.name) -- デバッグ用
                        vim_item.menu = ({
                            nvim_lsp = "[LSP]",
                            luasnip = "[SNIPPET]",
                            buffer = "[BUFFER]",
                            path = "[PATH]",
                            emoji = "[EMOJI]",
                        })[entry.source.name] or "[OTHER]"
                        return vim_item
                    end,
                },
                mapping = map.preset.insert({
                    ["<C-Space>"] = cmp.mapping.complete(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                    ["<Tab>"] = map(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<S-Tab>"] = map(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                }),
            })
        end,
    },
}
