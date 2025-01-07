local web_formatter = {
  "biome",
  "prettierd",
  stop_after_first = true,
}

return {
  "stevearc/conform.nvim",
  opts = function(_, opts)
    opts.formatters = {
      biome = {
        command = "biome",
        args = { "check", "--write", "--stdin-file-path", "$FILENAME" },
        stdin = true,
      },
    }

    opts.formatters_by_ft = {
      javascript = web_formatter,
      typescript = web_formatter,
      javascriptreact = web_formatter,
      typescriptreact = web_formatter,
      vue = web_formatter,
      svelte = web_formatter,
      json = web_formatter,
      jsonc = web_formatter,
      yaml = web_formatter,
      html = { "prettierd" },
      css = web_formatter,
      scss = web_formatter,
      less = web_formatter,
      lua = { "stylua" },
      python = { "ruff" },
      go = { "goimports", "gofmt" },
      php = { "php_cs_fixer" },
    }
  end,
}
