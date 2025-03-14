return {
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
