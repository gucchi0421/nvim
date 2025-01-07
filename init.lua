-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.autocmds")
require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/lua/snippets/" })

vim.opt.winbar = "%#WinBarPath#"
    .. " File: %t > "
    .. "%{%v:lua.require'nvim-navic'.get_location()%}"
    .. "%#WinBarPath#"
    .. "%=%{line('.')}:%{col('.')} %3p%% "

vim.cmd([[
    highlight WinBarPath guifg=#606060 guibg=#1c1c1c
    highlight NavicText guifg=#606060 guibg=#1c1c1c
    highlight NavicSeparator guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsFile guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsModule guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsNamespace guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsPackage guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsClass guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsMethod guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsProperty guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsField guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsConstructor guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsEnum guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsInterface guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsFunction guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsVariable guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsConstant guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsString guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsNumber guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsBoolean guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsArray guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsObject guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsKey guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsNull guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsEnumMember guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsStruct guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsEvent guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsOperator guifg=#606060 guibg=#1c1c1c
    highlight NavicIconsTypeParameter guifg=#606060 guibg=#1c1c1c
]])

local wk = require("which-key")
wk.add({
    { "<leader>c", group = "+code" },
    { "<leader>cg", desc = "+【Go】" },
    { "<leader>cs", desc = "+【Sass】" },
})

vim.lsp.set_log_level("debug")
vim.api.nvim_buf_set_option(0, "omnifunc", "")
vim.o.completeopt = "menu,menuone,noselect"
