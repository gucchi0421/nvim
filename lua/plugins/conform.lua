return {
    "stevearc/conform.nvim",
    opts = function(_, opts)
        -- Define your custom web formatter
        local web_formatter = { "biome", "prettierd", stop_after_first = true }

        -- Extend the existing formatters or add new ones
        opts.formatters_by_ft = vim.tbl_deep_extend("force", opts.formatters_by_ft or {}, {
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
        })
    end,
}
