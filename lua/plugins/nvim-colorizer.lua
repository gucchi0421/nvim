return {
  "catgoose/nvim-colorizer.lua",
  event = "BufReadPre",
  opts = {
    -- 有効にするファイルタイプ（例:全体で適用したい場合は`'*'`を指定）
    filetypes = { "*" },
    -- 反応させたい色形式のみを指定する
    user_default_options = {
      RGB = true, -- #RGB カラーコード
      RRGGBB = true, -- #RRGGBB カラーコード
      names = false, -- "black", "red" のような名前を無効化
      RRGGBBAA = true, -- #RRGGBBAA カラーコード
      rgb_fn = true, -- rgb(255, 255, 255) 形式
      hsl_fn = true, -- hsl(360, 100%, 50%) 形式
      css = false, -- CSS のデフォルトカラー (e.g., `red`) を無効化
      css_fn = true, -- CSS の関数形式 (e.g., `rgb()`, `hsl()`)
    },
  },
}
