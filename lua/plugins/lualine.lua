return {
    {
        "nvim-tree/nvim-web-devicons",
        lazy = true,
    },
    {
        'nvim-lualine/lualine.nvim',
        dependencies = { 'nvim-web-devicons' },
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
                            function()
                                local clients = vim.lsp.get_active_clients()
                                if #clients > 0 then
                                    return '🛠️ LSP: ACTIVE'
                                else
                                    return '🛠️ LSP: INACTIVE'
                                end
                            end,
                        },
                        -- 現在のアクティブなバッファ数
                        {
                            function()
                                local buffers = #vim.fn.getbufinfo({ buflisted = 1 })
                                return '📁 BUFFER: ' .. buffers
                            end,
                        },
                        -- ファイルサイズ
                        {
                            function()
                                local size = vim.fn.getfsize(vim.fn.expand('%:p'))
                                if size < 0 then return '📁 SIZE: N/A' end
                                return string.format('📁 SIZE: %.1f KB', size / 1024)
                            end,
                        },
                        -- 総行数
                        {
                            function()
                                local total_lines = vim.fn.line('$')
                                return '📝 LINE: ' .. total_lines
                            end,
                        },
                        -- 現在の行と列
                        {
                            function()
                                local cursor = vim.api.nvim_win_get_cursor(0)
                                return '📍 POS: ' .. cursor[1] .. ':' .. cursor[2]
                            end,
                        },
                        -- ファイル内の進行状況 (POSの右に配置)
                        {
                            'progress',
                        },
                    },

                    -- 右側:
                    lualine_x = {

                        {
                            function()
                                local handle = io.popen("grep 'cpu MHz' /proc/cpuinfo | awk '{print $4}' | head -n 1")
                                if handle then
                                    local cpu_mhz = handle:read("*a")
                                    handle:close()
                                    return cpu_mhz and ('⚙️  CPU: ' .. string.format('%.0f MHz', tonumber(cpu_mhz))) or
                                        ''
                                end
                                return ''
                            end,
                            cond = function()
                                return vim.fn.has('unix') == 1 and vim.fn.filereadable('/proc/cpuinfo') == 1
                            end,
                        },
                        {
                            function()
                                local handle = io.popen("free -m | awk '/Mem:/ {printf \"🧠 MEM: %.0f/%.0fMB\", $3, $2}'")
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
                    -- 右中央:
                    lualine_y = {
                        'encoding',
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
