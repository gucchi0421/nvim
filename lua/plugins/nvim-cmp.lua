return {
    -- {
    --     "ray-x/lsp_signature.nvim",
    --     opts = {
    --         toggle_key = "<A-p>",
    --     },
    -- },
    {
        "hrsh7th/nvim-cmp",
        enabled = true,
        dependencies = {
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-buffer",
            "hrsh7th/cmp-path",
            "saadparwaiz1/cmp_luasnip",
            "L3MON4D3/LuaSnip",
            "hrsh7th/cmp-emoji"
        },
        event = "InsertEnter",
        config = function()
            local cmp = require("cmp")
            local luasnip = require("luasnip")

            cmp.setup({
                completion = {
                    autocomplete = false,
                },
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                sources = {
                    { name = "nvim_lsp" },
                    { name = "luasnip" },
                    { name = "buffer" },
                    { name = "path" },
                    { name = "emoji" },
                },
                formatting = {
                    format = function(entry, vim_item)
                        vim_item.menu = ({
                            luasnip = "[SNIPPET]",
                            nvim_lsp = "[LSP]",
                            buffer = "[BUFFER]",
                            path = "[PATH]",
                            emoji = "[EMOJI]"
                        })[entry.source.name]
                        return vim_item
                    end
                }
            })
        end,
    },
}
