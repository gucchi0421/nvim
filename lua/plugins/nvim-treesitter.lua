return {
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            ensure_installed = {
                "bash",
                "regex",
                "go",
                "python",
                "lua",
                "php",
                "typescript",
                "tsx",
                "javascript",
                "html",
                "css",
                "json",
                "yaml",
                "graphql",
                "markdown",
                "markdown_inline",
                "vim",
                "query",
                "dockerfile",
                "toml",
                "prisma",
            },
            indent = { enable = true }, -- インデントを有効化
        },
    },
}
