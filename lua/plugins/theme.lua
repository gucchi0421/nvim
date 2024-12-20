return {
    -- transparent
    { "xiyaowong/transparent.nvim" },

    -- everforest
    -- { "neanias/everforest-nvim" },

    -- ayu
    {
        "Shatur/neovim-ayu",
        config = function()
            require("ayu").setup({
                mirage = true,
                overrides = {},
            })
        end,
    },

    -- テーマを選択
    {
        "LazyVim/LazyVim",
        opts = {
            -- colorscheme = "everforest",
            colorscheme = "ayu",
        },
    },
}
