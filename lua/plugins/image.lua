return {
    "samodostal/image.nvim",
    dependencies = {
        "nvim-lua/plenary.nvim",
    },
    config = function()
        require('image').setup {
            render = {
                min_padding = 5,
                show_label = true,
            },
        }
    end
}
