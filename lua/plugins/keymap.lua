return {
  {
    "mg979/vim-visual-multi",
    event = "VeryLazy",
    init = function()
      vim.g.VM_maps = {
        -- Ctrl+d で単語選択
        ["Find Under"] = "<C-d>",
        -- Ctrl+d でさらに選択
        ["Find Subword Under"] = "<C-d>",
        -- Ctrl+Shift+l で全選択
        ["Select All"] = "<C-S-l>",
        -- Ctrl+x で現在の選択をスキップ
        ["Skip Region"] = "<C-x>",
        -- Ctrl+p で現在の選択を削除
        ["Remove Region"] = "<C-p>",
      }
      -- テーマ設定
      vim.g.VM_theme = "ocean"
      -- 警告を非表示
      vim.g.VM_show_warnings = 0
      -- 終了時のメッセージを非表示
      vim.g.VM_silent_exit = 1
    end,
  },

  {
    -- gc  => コメントアウトメニュー
    -- gcc => カーソル位置のコメントアウト
    -- gco => カーソル下でコメント生成
    -- gcO => カーソル上でコメント生成
    "numToStr/Comment.nvim",
  },

  {
    "johmsalas/text-case.nvim",
    dependencies = { "nvim-telescope/telescope.nvim" },
    config = function()
      local textcase = require("textcase")
      local telescope = require("telescope")
      local opts = { noremap = true, silent = true }

      textcase.setup({})
      telescope.load_extension("textcase")

      -- Telescopeメニューを開く (全ケース変換オプションを表示)
      vim.api.nvim_set_keymap("n", ";;", "<Cmd>TextCaseOpenTelescope<CR>", opts)
      -- UPPER_CASE (例: EXAMPLE_TEXT)
      vim.api.nvim_set_keymap("n", ";u", "<Cmd>lua require('textcase').current_word('to_upper_case')<CR>", opts)
      -- lower_case (例: example_text)
      vim.api.nvim_set_keymap("n", ";l", "<Cmd>lua require('textcase').current_word('to_lower_case')<CR>", opts)
      -- snake_case (例: example_text)
      vim.api.nvim_set_keymap("n", ";s", "<Cmd>lua require('textcase').current_word('to_snake_case')<CR>", opts)
      -- dash-case (例: example-text)
      vim.api.nvim_set_keymap("n", ";d", "<Cmd>lua require('textcase').current_word('to_dash_case')<CR>", opts)
      -- camelCase (例: exampleText)
      vim.api.nvim_set_keymap("n", ";c", "<Cmd>lua require('textcase').current_word('to_camel_case')<CR>", opts)
      -- PascalCase (例: ExampleText)
      vim.api.nvim_set_keymap("n", ";p", "<Cmd>lua require('textcase').current_word('to_pascal_case')<CR>", opts)
      -- CONSTANT_CASE (例: EXAMPLE_TEXT)
      vim.api.nvim_set_keymap("n", ";n", "<Cmd>lua require('textcase').current_word('to_constant_case')<CR>", opts)
    end,
  },

  {
    "monaqa/dial.nvim",
    config = function()
      local augend = require("dial.augend")

      require("dial.config").augends:register_group({
        default = {
          -- 整数の増減
          augend.integer.alias.decimal,
          -- 16進数の増減
          augend.integer.alias.hex,
          -- 日付の増減 (YYYY/MM/DD)
          augend.date.alias["%Y/%m/%d"],
        },
        mygroup = {
          -- 整数の増減
          augend.integer.alias.decimal,
          -- true/falseのトグル
          augend.constant.alias.bool,
          -- 日付の増減 (MM/DD/YYYY)
          augend.date.alias["%m/%d/%Y"],
        },
      })

      -- 通常モードで値を増加
      vim.keymap.set("n", "<A-a>", require("dial.map").inc_normal(), { noremap = true })
      -- 通常モードで値を減少
      vim.keymap.set("n", "<A-x>", require("dial.map").dec_normal(), { noremap = true })
      -- ビジュアルモードで値を増加
      vim.keymap.set("v", "<A-a>", require("dial.map").inc_visual(), { noremap = true })
      -- ビジュアルモードで値を減少
      vim.keymap.set("v", "<A-x>", require("dial.map").dec_visual(), { noremap = true })
      -- 複数行で値を増加
      vim.keymap.set("v", "g<A-a>", require("dial.map").inc_gvisual(), { noremap = true })
      -- 複数行で値を減少
      vim.keymap.set("v", "g<A-x>", require("dial.map").dec_gvisual(), { noremap = true })
    end,
  },
  {
    {
      "psjay/buffer-closer.nvim",
      config = function()
        require("buffer-closer").setup({
          -- Qで開いているバッファを閉じる
          close_key = "Q",
        })
      end,
    },
  },
}
