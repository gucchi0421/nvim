return {
    {
        "L3MON4D3/LuaSnip",
        "rafamadriz/friendly-snippets",
        dependencies = { "rafamadriz/friendly-snippets" },
        version = "v2.*",
        build = "make install_jsregexp",
        config = function()
            require("luasnip.loaders.from_vscode").lazy_load()
        end,
    },
}
