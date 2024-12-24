return {
    {
        "johmsalas/text-case.nvim",
        dependencies = { "nvim-telescope/telescope.nvim" },
        config = function()
            local textcase = require("textcase")
            local telescope = require("telescope")
            local opts = { noremap = true, silent = true }

            textcase.setup({})
            telescope.load_extension("textcase")

            -- キーマッピング
            -- ;; => Telescopeメニューを開く (全ケース変換オプションを表示)
            vim.api.nvim_set_keymap("n", ";;", "<Cmd>TextCaseOpenTelescope<CR>", opts)
            -- ;u => UPPER_CASE (例: EXAMPLE_TEXT)
            vim.api.nvim_set_keymap("n", ";u", "<Cmd>lua require('textcase').current_word('to_upper_case')<CR>", opts)

            -- ;l => lower_case (例: example_text)
            vim.api.nvim_set_keymap("n", ";l", "<Cmd>lua require('textcase').current_word('to_lower_case')<CR>", opts)

            -- ;s => snake_case (例: example_text)
            vim.api.nvim_set_keymap("n", ";s", "<Cmd>lua require('textcase').current_word('to_snake_case')<CR>", opts)

            -- ;d => dash-case (例: example-text)
            vim.api.nvim_set_keymap("n", ";d", "<Cmd>lua require('textcase').current_word('to_dash_case')<CR>", opts)

            -- ;c => camelCase (例: exampleText)
            vim.api.nvim_set_keymap("n", ";c", "<Cmd>lua require('textcase').current_word('to_camel_case')<CR>", opts)

            -- ;p => PascalCase (例: ExampleText)
            vim.api.nvim_set_keymap("n", ";p", "<Cmd>lua require('textcase').current_word('to_pascal_case')<CR>", opts)

            -- ;n => CONSTANT_CASE (例: EXAMPLE_TEXT)
            vim.api.nvim_set_keymap("n", ";n", "<Cmd>lua require('textcase').current_word('to_constant_case')<CR>", opts)
        end,
    },
}
