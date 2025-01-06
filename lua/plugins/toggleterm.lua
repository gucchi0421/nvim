vim.cmd([[
  autocmd TermOpen * setlocal winhighlight=Normal:Normal
]])

return {
  "akinsho/toggleterm.nvim",
  version = "*",
  config = function()
    local toggleterm = require("toggleterm")

    -- 基本設定
    toggleterm.setup({
      size = 20,
      open_mapping = [[<C-\>]],
      hide_numbers = true,
      shade_terminals = false, -- 背景を暗くする機能を無効化
      start_in_insert = true,
      insert_mappings = true,
      terminal_mappings = true,
      persist_size = true,
      close_on_exit = true,
      direction = "float",
      float_opts = {
        border = "curved",
        winblend = 0, -- 背景透過を完全無効化
        title_pos = "center",
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
    })

    local Terminal = require("toggleterm.terminal").Terminal

    -- lazygit用のターミナル設定
    local lazygit = Terminal:new({
      cmd = "lazygit",
      dir = "git_dir",
      direction = "float",
      float_opts = {
        winblend = 0, -- 背景透過を完全に無効化
      },
      on_open = function(term)
        vim.cmd("setlocal winhighlight=Normal:Normal,FloatBorder:Normal")
        vim.cmd("startinsert!")
      end,
      on_close = function()
        vim.cmd("checktime")
      end,
    })

    -- lazydocker用のターミナル設定
    local lazydocker = Terminal:new({
      cmd = "lazydocker",
      direction = "float",
      float_opts = {
        winblend = 0, -- 背景透過を完全に無効化
      },
      on_open = function(term)
        vim.cmd("setlocal winhighlight=Normal:Normal,FloatBorder:Normal")
        vim.cmd("startinsert!")
      end,
    })

    -- lazygitをトグルする関数
    _G.lazygit_toggle = function()
      lazygit:toggle()
    end

    -- lazydockerをトグルする関数
    _G.lazydocker_toggle = function()
      lazydocker:toggle()
    end

    -- キーマッピング設定
    vim.api.nvim_set_keymap("n", "<leader>gg", "<cmd>lua lazygit_toggle()<CR>", {
      noremap = true,
      silent = true,
    })

    vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua lazydocker_toggle()<CR>", {
      noremap = true,
      silent = true,
    })

    -- ターミナルを閉じるためのキー設定
    vim.keymap.set("t", "Q", [[<C-\><C-n>:q<CR>]], { noremap = true, silent = true })
  end,
}
