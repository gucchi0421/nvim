return {
    {
        "hrsh7th/nvim-cmp",
        opts = function(_, opts)
            opts.mapping = {
                ["<CR>"] = require("cmp").mapping.confirm({ select = true }),
                ["<Tab>"] = require("cmp").mapping.select_next_item(),
                ["<S-Tab>"] = require("cmp").mapping.select_prev_item(),
            }
        end,
    },
}
