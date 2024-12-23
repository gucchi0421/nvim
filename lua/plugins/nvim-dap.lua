return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "leoluz/nvim-dap-go",
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            -- Goの設定
            require('dap-go').setup()

            -- Pythonの設定
            require('dap-python').setup('python3')

            -- デバッグUIの設定
            local dap, dapui = require("dap"), require("dapui")
            dapui.setup()

            -- UIの自動表示/非表示
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end

            -- キーマップ設定
            vim.keymap.set('n', '<F5>', function() require('dap').continue() end)
            vim.keymap.set('n', '<F10>', function() require('dap').step_over() end)
            vim.keymap.set('n', '<F11>', function() require('dap').step_into() end)
            vim.keymap.set('n', '<F12>', function() require('dap').step_out() end)
            vim.keymap.set('n', '<leader><F10>', function() require('dap').toggle_breakpoint() end)
            vim.keymap.set('n', '<leader><F11>',
                function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end)
        end,
    },
}
