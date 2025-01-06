return {
  "monkoose/neocodeium",
  event = "VeryLazy",
  config = function()
    local neocodeium = require("neocodeium")
    neocodeium.setup()
    -- 入力中の候補を確定
    vim.keymap.set("i", "<C-]>", neocodeium.accept)
    -- 複数候補ある場合に次の候補を表示
    vim.keymap.set("i", "<A-h>", function()
      neocodeium.cycle(1)
    end)
    -- 前の候補を表示
    vim.keymap.set("i", "<A-l>", function()
      neocodeium.cycle(-1)
    end)
  end,
}
