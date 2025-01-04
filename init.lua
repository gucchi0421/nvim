-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.autocmds")
require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/lua/snippets/" })

local wk = require("which-key")
wk.add({
    { "<leader>c",  group = "+code" },
    { "<leader>cg", desc = "+Go" },
    { "<leader>cs", desc = "+Sass" },
})
