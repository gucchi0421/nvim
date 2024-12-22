return {
    -- transparent
    { "xiyaowong/transparent.nvim" },

    -- everforest
    -- { "neanias/everforest-nvim" },
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "everforest",
    --     },
    -- },

    -- kanagawa-paper
    -- {
    --     "sho-87/kanagawa-paper.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    -- },
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "kanagawa-paper",
    --     },
    -- },

    -- sakurajima
    {
        "Daiki48/sakurajima.nvim",
        lazy = false,
        branch = "main",
        config = function()
            vim.cmd([[colorscheme sakurajima]])
        end,
    },

    -- tokyonight
    -- {
    --     "folke/tokyonight.nvim",
    --     lazy = false,
    --     priority = 1000,
    --     opts = {},
    -- },
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "tokyonight-night",
    --     },
    -- },

    -- ayu
    -- {
    --     "Shatur/neovim-ayu",
    --     config = function()
    --         require("ayu").setup({
    --             mirage = true,
    --             overrides = {},
    --         })
    --     end,
    -- },
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "ayu",
    --     },
    -- },

    -- nordic
    -- {
    --     'AlexvZyl/nordic.nvim',
    --     lazy = false,
    --     priority = 1000,
    --     config = function()
    --         require('nordic').load()
    --     end
    -- },
    -- {
    --     "LazyVim/LazyVim",
    --     opts = {
    --         colorscheme = "nordic",
    --     },
    -- },
}
