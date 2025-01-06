local keys = "" -- 入力されたキーシーケンスを保存

-- キー入力を監視する関数
local function key_logger(char)
  local key = vim.fn.keytrans(char) -- キー入力を文字列に変換

  -- 無視するキーパターンをより詳細に定義
  local ignore_patterns = {
    "^<.*Mouse.*>", -- すべてのマウス関連イベント
    "^<.*Scroll.*>", -- すべてのスクロール関連イベント
    "^<.*Drag.*>", -- ドラッグ関連イベント
    "^<.*Release.*>", -- リリース関連イベント
    "^<.*Click.*>", -- クリック関連イベント
    "^<.*-.*-.*>", -- 複数の修飾キーを含むもの
    "^<F%d+>", -- ファンクションキー
    "^<.*Tab>", -- タブ関連
    "^<BS>", -- バックスペース
    "^<Del>", -- デリート
    "^<Home>", -- Home
    "^<End>", -- End
    "^<Insert>", -- Insert
    "^<PageUp>", -- PageUp
    "^<PageDown>", -- PageDown
    "^<CR>", -- Enter
    "^<Space>", -- スペース
    "^<[CS]-%a>", -- Ctrl-やShift-で始まる単文字
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
  local venv_path = vim.fn.getcwd() .. "/.venv"
  if vim.fn.isdirectory(venv_path) == 1 then
    vim.env.VIRTUAL_ENV = venv_path
    vim.env.PATH = venv_path .. "/bin:" .. vim.env.PATH
    _G.ACTIVE_VENV = venv_path
    vim.notify("Activated venv: " .. venv_path, vim.log.levels.INFO, { title = "Python Environment" })
  end
end

vim.api.nvim_create_autocmd("FileType", {
  pattern = "python",
  callback = function()
    auto_activate_venv()
  end,
  desc = "Auto activate Python venv",
})

return {
  {
    "nvim-tree/nvim-web-devicons",
    lazy = true,
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-web-devicons", "pnx/lualine-lsp-status" },
    event = { "BufNewFile", "BufRead" },
    config = function()
      require("lualine").setup({
        options = {
          theme = "auto",
          globalstatus = true,
          component_separators = "",
          section_separators = "",
        },
        sections = {
          -- 左側
          lualine_a = {
            {
              "mode",
              fmt = function(str)
                local modes = {
                  ["NORMAL"] = "🐱 NORMAL",
                  ["INSERT"] = "😼 INSERT",
                  ["VISUAL"] = "😸 VISUAL",
                  ["TERMINAL"] = "😻 TERMINAL",
                  ["COMMAND"] = "😻 COMMAND",
                }
                return modes[str] or str
              end,
            },
          },
          lualine_b = {
            -- Gitブランチ
            {
              "branch",
              icon = "",
            },
            -- Git差分
            {
              "diff",
              symbols = { added = "➕ ", modified = "✏️  ", removed = "❌ " },
              colored = true,
            },
          },

          -- 中央:
          lualine_c = {
            {
              -- ファイルタイプを表示
              "filetype",
              icon_only = false,
            },
            {
              "lsp-status",
            },
            {
              function()
                local ft = vim.bo.filetype
                if ft == "python" and _G.ACTIVE_VENV then
                  return "" .. vim.fn.fnamemodify(_G.ACTIVE_VENV, ":t") -- ダイヤモンド
                end
                return ""
              end,
            },
            {
              function()
                -- より厳密なファイルチェック
                local filename = vim.fn.expand("%")
                local bufname = vim.fn.bufname()
                local buftype = vim.bo.buftype

                -- バッファタイプが空でない、またはファイル名が空の場合は表示しない
                if buftype ~= "" or filename == "" or bufname == "" then
                  return ""
                end

                -- 通常のファイルでない場合は表示しない
                if not vim.fn.filereadable(filename) then
                  return ""
                end

                local enc = vim.opt.fileencoding:get() ~= "" and vim.opt.fileencoding:get() or ""

                -- ファイルフォーマット (改行コード)
                local fileformat = vim.bo.fileformat
                local fileformat_symbol = fileformat == "unix" and "LF" or (fileformat == "dos" and "CRLF" or "CR")

                -- statコマンドの実行
                local stat_info = ""
                local ok, stats = pcall(vim.fn.systemlist, 'stat -c "%A %U %G %s(B) %y" ' .. filename)
                if ok and stats[1] then
                  stat_info = stats[1]:gsub("%.%d+", ""):gsub("%+.*", "")
                end

                return string.format(
                  "%s %s %s  %s",
                  stat_info ~= "" and "📄" or "",
                  stat_info,
                  enc,
                  fileformat_symbol
                )
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
              color = { fg = "#fa8072" },
            },
          },
          -- 右中央:
          lualine_y = {
            {
              function()
                local handle = io.popen("free -m | awk '/Mem:/ {printf \"💽 %.0f/%.0f(MB)\", $3, $2}'")
                if handle then
                  local mem = handle:read("*a")
                  handle:close()
                  return mem or ""
                end
                return ""
              end,
              cond = function()
                return vim.fn.has("unix") == 1 and vim.fn.executable("free") == 1
              end,
            },
          },
          -- 右端:
          lualine_z = {
            {
              function()
                return os.date("🕒 %H:%M:%S")
              end,
            },
          },
        },
        extensions = { "quickfix", "fugitive" },
      })
    end,
  },
}
