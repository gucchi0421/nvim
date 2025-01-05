-- config/autocmds.lua
vim.api.nvim_create_autocmd("ColorScheme", {
    callback = function()
        vim.cmd([[ highlight WinBarPath guifg=#606060 guibg=#1c1c1c ]])
    end,
})

-- ================================================
-- カーソル位置を記憶し再開時にスムージングスクロール
-- ================================================
local group = vim.api.nvim_create_augroup("smooth_scroll_to_cursor", { clear = true })
vim.api.nvim_create_autocmd("BufReadPost", {
    group = group,
    callback = function()
        -- 最後のカーソル位置を取得
        local last_pos = vim.fn.line([['"]])
        if last_pos >= 1 and last_pos <= vim.fn.line("$") then
            -- カーソルをファイルの先頭に移動
            vim.api.nvim_win_set_cursor(0, { 1, 0 })
            -- 少し遅延させてから最後のカーソル位置までスクロール
            vim.defer_fn(function()
                vim.api.nvim_win_set_cursor(0, { last_pos, 0 })
                -- 'zz' コマンドでカーソル位置を中心にスクロール
                vim.cmd("normal! zz")
            end, 150) -- 遅延時間はミリ秒で指定
        end
    end,
})

-- ================================================
-- Sassの自動コンパイル
-- ================================================
-- ジョブ管理用テーブル
local sass_jobs = {}

-- 再帰的に特定のディレクトリを検出
local function detect_directory(name, default_path)
    local current_dir = vim.fn.getcwd()
    -- まず、現在のディレクトリの直下を検索
    local dirs = vim.fn.glob(current_dir .. "/*/" .. name, false, true)

    -- 見つからなければ、1階層深く検索
    if #dirs == 0 then
        dirs = vim.fn.glob(current_dir .. "/*/*/" .. name, false, true)
    end

    if #dirs > 0 then
        -- 最も短いパス（浅い階層）を選択
        table.sort(dirs, function(a, b) return #a < #b end)
        -- 相対パスに変換
        local relative_path = vim.fn.fnamemodify(dirs[1], ":.")
        return relative_path
    end

    return default_path
end

-- Sassファイルや出力先ディレクトリの入力処理
local function get_sass_config()
    -- `scss`と`css`ディレクトリを検出
    local sass_dir = detect_directory("scss", "./scss")
    local output_dir = detect_directory("css", "./css")

    -- デフォルトファイルの候補リスト
    local default_files = {
        sass_dir .. "/style.scss",
        sass_dir .. "/index.scss"
    }

    -- デフォルトファイルを検索
    local default_file = nil
    for _, file in ipairs(default_files) do
        if vim.fn.filereadable(file) == 1 then
            default_file = file
            break
        end
    end

    -- Sassファイル検出（デフォルトが見つからない場合の候補用）
    local detected_files = vim.fn.glob(sass_dir .. "/**/*.scss", false, true)

    -- デフォルトファイルが見つからなかった場合は、検出されたファイルの1つ目を使用
    default_file = default_file or (#detected_files > 0 and detected_files[1] or "")

    local prompt = default_file ~= ""
        and string.format("Target Sass file (default: %s): ", default_file)
        or "Target Sass file: "

    local sass_file = vim.fn.input(prompt, default_file)
    if sass_file == "" then
        vim.notify("No Sass file specified.", vim.log.levels.ERROR)
        return nil
    end

    -- 出力ディレクトリの設定
    output_dir = vim.fn.input(
        string.format("Output directory (default: %s): ", output_dir),
        output_dir
    )
    if output_dir == "" then
        vim.notify("No output directory specified.", vim.log.levels.ERROR)
        return nil
    end

    -- ソースマップの設定
    local create_map = vim.fn.input("Create source map? (y/n): ", "y")
    local map_option = create_map:lower() == "y" and "--source-map" or "--no-source-map"

    -- 出力ファイル名を生成
    local output_file = output_dir .. "/" .. vim.fn.fnamemodify(sass_file, ":t:r") .. ".css"

    return {
        sass_file = sass_file,
        output_file = output_file,
        map_option = map_option,
    }
end

-- Sassコマンドを実行
local function execute_sass_command(sass_file, output_file, map_option, mode)
    local sass_command
    if mode == "watch" then
        sass_command = string.format("sass --watch %s:%s %s", sass_file, output_file, map_option)
    else
        sass_command = string.format("sass %s:%s %s", sass_file, output_file, map_option)
    end

    -- 実行前確認
    local confirm = vim.fn.input(string.format("Execute the following command?\n%s\n(y/n): ", sass_command), "y")
    if confirm:lower() ~= "y" then
        vim.notify("Operation cancelled.", vim.log.levels.WARN)
        return
    end

    if mode == "watch" then
        -- 非同期ジョブ開始
        local job_id = vim.fn.jobstart(sass_command, {
            stdout_buffered = true,
            stderr_buffered = true,
            on_stdout = function(_, data)
                if data then
                    for _, line in ipairs(data) do
                        if line ~= "" then
                            vim.notify(line, vim.log.levels.INFO)
                        end
                    end
                end
            end,
            on_stderr = function(_, data)
                if data then
                    for _, line in ipairs(data) do
                        if line ~= "" then
                            vim.notify(line, vim.log.levels.ERROR)
                        end
                    end
                end
            end,
            on_exit = function(_, code)
                if code == 0 then
                    vim.notify("Sass watch ended.", vim.log.levels.INFO)
                else
                    vim.notify("Error occurred during Sass watch.", vim.log.levels.ERROR)
                end
            end,
        })

        if job_id > 0 then
            sass_jobs[sass_file] = job_id
            vim.notify("Started Sass watch: " .. sass_command, vim.log.levels.INFO)
        else
            vim.notify("Failed to start Sass watch.", vim.log.levels.ERROR)
        end
    else
        -- 単発実行
        local output = vim.fn.system(sass_command)
        if vim.v.shell_error == 0 then
            vim.notify("Compiled Sass: " .. output_file, vim.log.levels.INFO)
        else
            vim.notify("Error during compilation:\n" .. output, vim.log.levels.ERROR)
        end
    end
end

-- 監視モード
local function sass_watch()
    local config = get_sass_config()
    if config then
        execute_sass_command(config.sass_file, config.output_file, config.map_option, "watch")
    end
end

-- 単発モード
local function sass_once()
    local config = get_sass_config()
    if config then
        execute_sass_command(config.sass_file, config.output_file, config.map_option, "once")
    end
end

-- 監視停止
local function sass_stop()
    -- アクティブなジョブの一覧を表示
    local active_jobs = {}
    for file, _ in pairs(sass_jobs) do
        table.insert(active_jobs, file)
    end

    if #active_jobs == 0 then
        vim.notify("No active Sass watch found.", vim.log.levels.WARN)
        return
    end

    -- 選択肢を作成
    local choices = table.concat(active_jobs, "\n")
    local sass_file = vim.fn.input("Select Sass file to stop watching:\n" .. choices .. "\n> ")

    local job_id = sass_jobs[sass_file]
    if job_id then
        vim.fn.jobstop(job_id)
        sass_jobs[sass_file] = nil
        vim.notify("Stopped watching: " .. sass_file, vim.log.levels.INFO)
    else
        vim.notify("No watch found for specified Sass file.", vim.log.levels.ERROR)
    end
end

-- コマンド登録
vim.api.nvim_create_user_command("SassWatch", sass_watch, { desc = "Start Sass watch" })
vim.api.nvim_create_user_command("SassOnce", sass_once, { desc = "Compile Sass once" })
vim.api.nvim_create_user_command("SassStop", sass_stop, { desc = "Stop Sass watch" })

-- キーバインド
vim.api.nvim_set_keymap("n", "<leader>csw", ":SassWatch<CR>", { noremap = true, silent = true, desc = "Sass watch" })
vim.api.nvim_set_keymap("n", "<leader>css", ":SassOnce<CR>", { noremap = true, silent = true, desc = "Sass compile" })
vim.api.nvim_set_keymap("n", "<leader>csq", ":SassStop<CR>", { noremap = true, silent = true, desc = "Stop sass watch" })



local autocmd = vim.api.nvim_create_autocmd

autocmd({ 'ModeChanged' }, {
    callback = function()
        local current_mode = vim.fn.mode()
        if current_mode == 'n' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#8aa872' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        elseif current_mode == 'v' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        elseif current_mode == 'V' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        elseif current_mode == '�' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#bf616a' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        elseif current_mode == 'i' then
            vim.api.nvim_set_hl(0, 'SmoothCursor', { fg = '#668aab' })
            vim.fn.sign_define('smoothcursor', { text = '' })
        end
    end,
})
