local keys = "" -- 入力されたキーシーケンスを保存

-- キー入力を監視する関数
local function key_logger(char)
    local key = vim.fn.keytrans(char) -- キー入力を文字列に変換

    -- 無視するキーパターンをより詳細に定義
    local ignore_patterns = {
        "^<.*Mouse.*>",   -- すべてのマウス関連イベント
        "^<.*Scroll.*>",  -- すべてのスクロール関連イベント
        "^<.*Drag.*>",    -- ドラッグ関連イベント
        "^<.*Release.*>", -- リリース関連イベント
        "^<.*Click.*>",   -- クリック関連イベント
        "^<.*-.*-.*>",    -- 複数の修飾キーを含むもの
        "^<F%d+>",        -- ファンクションキー
        "^<.*Tab>",       -- タブ関連
        "^<BS>",          -- バックスペース
        "^<Del>",         -- デリート
        "^<Home>",        -- Home
        "^<End>",         -- End
        "^<Insert>",      -- Insert
        "^<PageUp>",      -- PageUp
        "^<PageDown>",    -- PageDown
        "^<CR>",          -- Enter
        "^<Space>",       -- スペース
        "^<[CS]-%a>",     -- Ctrl-やShift-で始まる単文字
    }

    -- EscやCtrl+Cでリセット
    if key == "<Esc>" or key == "<C-c>" then
        keys = ""
        return
    end

    -- 定義したパターンに一致するキーは無視
    for _, pattern in ipairs(ignore_patterns) do
        if key:match(pattern) then
            return
        end
    end

    -- 最新のキーをシーケンスに追加
    if #key > 0 then
        keys = keys .. " " .. key
    end

    -- 最大3つに制限
    local key_list = vim.split(keys, " ", { trimempty = true })
    if #key_list > 5 then
        keys = table.concat(vim.list_slice(key_list, #key_list - 2, #key_list), " ")
    end
end

-- キーイベントをキャプチャ
vim.on_key(key_logger)


-- 環境変数を格納する変数
_G.ACTIVE_VENV = nil

local function auto_activate_venv()
    local venv_path = vim.fn.getcwd() .. '/.venv'
    if vim.fn.isdirectory(venv_path) == 1 then
        vim.env.VIRTUAL_ENV = venv_path
        vim.env.PATH = venv_path .. '/bin:' .. vim.env.PATH
        _G.ACTIVE_VENV = venv_path
        vim.notify('Activated venv: ' .. venv_path, vim.log.levels.INFO, { title = 'Python Environment' })
    end
end

vim.api.nvim_create_autocmd('FileType', {
    pattern = 'python',
    callback = function()
        auto_activate_venv()
    end,
    desc = 'Auto activate Python venv'
})

return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-web-devicons', 'pnx/lualine-lsp-status' },
        event = { 'BufNewFile', 'BufRead' },
        config = function()
            require('lualine').setup({
                options = {
                    theme = 'auto',
                    globalstatus = true,
                    component_separators = '',
                    section_separators = '',
                },
                sections = {
                    -- 左側
                    lualine_a = {
                        {
                            'mode',
                            fmt = function(str)
                                local modes = {
                                    ['NORMAL'] = '🐱 NORMAL',
                                    ['INSERT'] = '😼 INSERT',
                                    ['VISUAL'] = '😸 VISUAL',
                                    ['TERMINAL'] = '😻 TERMINAL',
                                    ['COMMAND'] = '😻 COMMAND',
                                }
                                return modes[str] or str
                            end,
                        },
                    },
                    lualine_b = {
                        -- Gitブランチ
                        {
                            'branch',
                            icon = ''
                        },
                        -- Git差分
                        {
                            'diff',
                            symbols = { added = '➕ ', modified = '✏️  ', removed = '❌ ' },
                            colored = true,
                        },

                    },

                    -- 中央:
                    lualine_c = {
                        {
                            -- ファイルタイプを表示
                            'filetype',
                            icon_only = false,
                        },
                        {
                            'lsp-status',
                        },
                        -- {
                        --     function()
                        --         local clients = vim.lsp.get_active_clients({ bufnr = 0 })
                        --         local lsp_names = {}
                        --         for _, client in ipairs(clients) do
                        --             if client.name ~= "null-ls" then
                        --                 table.insert(lsp_names, client.name)
                        --             end
                        --         end
                        --         if #lsp_names > 0 then
                        --             return "» " .. table.concat(lsp_names, ", ") -- シンプルな矢印
                        --         end
                        --         return ""
                        --     end,
                        -- },
                        {
                            function()
                                local ft = vim.bo.filetype
                                if ft == 'python' and _G.ACTIVE_VENV then
                                    return "" .. vim.fn.fnamemodify(_G.ACTIVE_VENV, ':t') -- ダイヤモンド
                                end
                                return ''
                            end,
                        },
                        {
                            function()
                                -- ファイルが存在する場合のみ実行
                                if vim.fn.expand('%') ~= '' then
                                    local enc = vim.opt.fileencoding:get() ~= '' and vim.opt.fileencoding:get() or ''

                                    -- ファイルが実際に存在する場合のみstatを実行
                                    local stat_info = ''
                                    if vim.fn.filereadable(vim.fn.expand('%')) == 1 then
                                        local ok, stats = pcall(vim.fn.systemlist,
                                            'stat -c "%A %U %G %s %y" ' .. vim.fn.expand('%'))
                                        if ok and stats[1] then
                                            stat_info = stats[1]:gsub('%.%d+', ''):gsub('%+.*', '')
                                        end
                                    end

                                    return string.format('📄 %s%s', stat_info, enc)
                                end
                                return ''
                            end,
                        },
                    },

                    -- 右側:
                    lualine_x = {
                        {
                            function()
                                if keys == "" then
                                    return ""
                                end
                                return keys
                            end,
                            color = { fg = '#fa8072' }
                        },

                    },
                    -- 右中央:
                    lualine_y = {
                        -- {
                        --     function()
                        --         local handle = io.popen("grep 'cpu MHz' /proc/cpuinfo | awk '{print $4}' | head -n 1")
                        --         if handle then
                        --             local cpu_mhz = handle:read("*a")
                        --             handle:close()
                        --             return cpu_mhz and ('⚙️  ' .. string.format('%.0f(MHz)', tonumber(cpu_mhz))) or
                        --                 ''
                        --         end
                        --         return ''
                        --     end,
                        --     cond = function()
                        --         return vim.fn.has('unix') == 1 and vim.fn.filereadable('/proc/cpuinfo') == 1
                        --     end,
                        -- },
                        {
                            function()
                                local handle = io.popen(
                                    "free -m | awk '/Mem:/ {printf \"💽 %.0f/%.0f(MB)\", $3, $2}'")
                                if handle then
                                    local mem = handle:read("*a")
                                    handle:close()
                                    return mem or ''
                                end
                                return ''
                            end,
                            cond = function()
                                return vim.fn.has('unix') == 1 and vim.fn.executable('free') == 1
                            end,
                        },
                    },
                    -- 右端:
                    lualine_z = {
                        {
                            function() return os.date('🕒 %H:%M:%S') end,
                        },
                    },
                },
                extensions = { 'quickfix', 'fugitive' },
            })
        end,
    },
}
