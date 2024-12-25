return {
    {
        "monaqa/dial.nvim",
        config = function()
            -- augendのカスタム設定を記述
            local augend = require("dial.augend")

            require("dial.config").augends:register_group {
                -- デフォルトグループ
                default = {
                    augend.integer.alias.decimal,  -- 整数
                    augend.integer.alias.hex,      -- 16進数
                    augend.date.alias["%Y/%m/%d"], -- 日付 (YYYY/MM/DD)
                },

                -- カスタムグループ
                mygroup = {
                    augend.integer.alias.decimal,  -- 整数
                    augend.constant.alias.bool,    -- true/false
                    augend.date.alias["%m/%d/%Y"], -- 日付 (MM/DD/YYYY)
                },
            }

            -- キーマッピングの設定
            vim.keymap.set("n", "<A-a>", require("dial.map").inc_normal(), { noremap = true })
            vim.keymap.set("n", "<A-x>", require("dial.map").dec_normal(), { noremap = true })
            vim.keymap.set("v", "<A-a>", require("dial.map").inc_visual(), { noremap = true })
            vim.keymap.set("v", "<A-x>", require("dial.map").dec_visual(), { noremap = true })
            vim.keymap.set("v", "g<A-a>", require("dial.map").inc_gvisual(), { noremap = true })
            vim.keymap.set("v", "g<A-x>", require("dial.map").dec_gvisual(), { noremap = true })
        end,
    },
}
