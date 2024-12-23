return {
    -- スニペットプラグイン
    {
        "L3MON4D3/LuaSnip",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
    -- スニペットのサポート
    {
        "rafamadriz/friendly-snippets", -- HTML/CSS用の既存スニペットを提供
    },
}
