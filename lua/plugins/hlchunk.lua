return {
    {
        "shellRaining/hlchunk.nvim",
        event = { "BufReadPre", "BufNewFile" },
        config = function()
            require("hlchunk").setup({
                chunk = {
                    enable = true,
                    horizontal_line = "─",
                    vertical_line = "│",
                    left_top = "╭",
                    left_bottom = "╰",
                    right_arrow = ">",
                },
                indent = {
                    enable = true,
                    indent_style = "none"
                },
                blank = {
                    enable = false
                },
            })
        end
    },
    {
        "echasnovski/mini.indentscope",
        enabled = false,
    },
    {
        "lukas-reineke/indent-blankline.nvim",
        enabled = false,
    },
    {
        "snacks.nvim",
        opts = {
            indent = { enabled = false }, -- Snacksプラグインのインデントを無効化
        },
    },
}
