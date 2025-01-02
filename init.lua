-- bootstrap lazy.nvim, LazyVim and your plugins
require("config.lazy")
require("config.autocmds")
require("luasnip.loaders.from_snipmate").load({ paths = "~/.config/nvim/lua/snippets/" })

vim.o.winbar =
"%#WinBarPath# ./%{expand('%:p:.')}%=[ %{&fileencoding != '' ? &fileencoding : 'utf-8'} ] [ %{&fileformat != '' ? &fileformat : 'unix'} ]  "

vim.cmd([[
highlight WinBarPath guifg=#606060 guibg=#1c1c1c
]])

local function auto_activate_venv()
    local venv_path = vim.fn.getcwd() .. '/.venv'
    if vim.fn.isdirectory(venv_path) == 1 then
        vim.env.VIRTUAL_ENV = venv_path
        vim.env.PATH = venv_path .. '/bin:' .. vim.env.PATH
        -- 仮想環境をアクティベートした際に通知を表示
        vim.notify(
            'Activated venv: ' .. venv_path,
            vim.log.levels.INFO,
            { title = 'Python Environment' }
        )
    end
end

-- .pyファイルを開いたときのみ実行
vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        auto_activate_venv()
    end,
    desc = 'Auto activate Python venv'
})
