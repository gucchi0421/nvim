return {
    {
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        dependencies = { "rafamadriz/friendly-snippets" },
        config = function()
            -- vscodeっぽい補完をインストール
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
