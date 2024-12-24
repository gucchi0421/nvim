return {
    {
        "coffebar/neovim-project",
        opts = {
            projects = { -- define project roots
                "~/documents/functions/*",
                "~/documents/services/*",
                "~/documents/tools/*",
                "~/documents/workspace/*/*",
                "~/documents/works/*",
                "~/documents/zenn/*",
                "~/.config/nvim/",
                "~/.config/lazygit/",
            },
            picker = {
                type = "telescope", -- or "fzf-lua"
            },
            last_session_on_startup = true,
            filetype_autocmd_timeout = 200,
        },
        init = function()
            -- enable saving the state of plugins in the session
            vim.opt.sessionoptions:append("globals") -- save global variables that start with an uppercase letter and contain at least one lowercase letter.
        end,
        dependencies = {
            { "nvim-lua/plenary.nvim" },
            { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
            { "ibhagwan/fzf-lua" },
            { "Shatur/neovim-session-manager" },
        },
        lazy = false,
        priority = 100,
    },
}
