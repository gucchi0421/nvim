return {
    "stevearc/conform.nvim",
    config = function()
        local web_formatter = { "biome", "prettierd", stop_after_first = true }
        require("conform").setup({
            formatters_by_ft = {
                bash = { "shfmt" },
                lua = { "stylua" },
                go = { "goimports", "gofmt" },
                python = { "isort", "black" },
                rust = { "rustfmt" },
                php = { "php_cs_fixer" },
                -- Web
                typescript = web_formatter,
                javascript = web_formatter,
                typescriptreact = web_formatter,
                javascriptreact = web_formatter,
                vue = web_formatter,
                svelte = web_formatter,
                json = web_formatter,
                jsonc = web_formatter,
                yaml = web_formatter,
                html = web_formatter,
                css = web_formatter,
                scss = web_formatter,
                less = web_formatter,
            },
            format_on_save = {
                timeout_ms = 500,
                lsp_format = "fallback",
            },
        })
    end,
}
