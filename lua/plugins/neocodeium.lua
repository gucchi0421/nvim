return {
    "monkoose/neocodeium",
    event = "VeryLazy",
    config = function()
        local neocodeium = require("neocodeium")
        neocodeium.setup()
        -- 公式の例だと<A-f>にマッピングされていますが、<Tab>に変えてます。
        vim.keymap.set("i", "<Tab>", neocodeium.accept)
        -- 複数候補ある場合に次の候補を表示
        vim.keymap.set("i", "<C-j>", function()
            neocodeium.cycle(1)
        end)
        -- 前の候補を表示
        vim.keymap.set("i", "<C-k>", function()
            neocodeium.cycle(-1)
        end)
    end,
}
