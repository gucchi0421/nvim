return {
  {
    "sontungexpt/buffer-closer",
    event = "VeryLazy",
    config = function()
      require("buffer-closer").setup({
        -- 最低6つのバッファを残す
        min_remaining_buffers = 5,

        -- 1分間はバッファを保持
        retirement_minutes = 1,
      })
    end,
  },
  {
    "psjay/buffer-closer.nvim",
    config = function()
      require("buffer-closer").setup({
        -- Qで開いているバッファを閉じる
        close_key = "Q",
      })
    end,
  },
}
