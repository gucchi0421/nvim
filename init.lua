-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.autocmds")
require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/lua/snippets/" })

vim.o.winbar =
"%#WinBarPath# ./%{expand('%:p:.')}%=[ %{&fileencoding != '' ? &fileencoding : 'utf-8'} ] [ %{&fileformat != '' ? &fileformat : 'unix'} ]  "

vim.cmd([[
highlight WinBarPath guifg=#606060 guibg=#1c1c1c
]])
