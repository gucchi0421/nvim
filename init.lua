-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/lua/snippets/" })

vim.o.winbar = "%#MyWinbar# %* %f" -- Winbarに「Neo-tree」とファイル名を表示
vim.cmd [[
highlight AirlineTabline guifg=#ffffff guibg=#3c3836
highlight AirlineTablineSel guifg=#ffffff guibg=#458588
]]