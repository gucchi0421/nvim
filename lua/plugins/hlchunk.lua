return {
  {
    "shellRaining/hlchunk.nvim",
    event = { "BufReadPre", "BufNewFile" },
    config = function()
      require("hlchunk").setup({
        chunk = {
          enable = true,
          horizontal_line = "─",
          vertical_line = "│",
          left_top = "╭",
          left_bottom = "╰",
          right_arrow = ">",
          use_treesitter = true,
        },
        indent = {
          enable = true,
          priority = 10,
          style = {
            "#6E6B6B",
          },
          use_treesitter = false,
          chars = { "┊" },
          ahead_lines = 20,
          delay = 100,
        },
        blank = {
          enable = false,
        },
      })
    end,
  },
  {
    "echasnovski/mini.indentscope",
    enabled = false,
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    enabled = false,
  },
  {
    "snacks.nvim",
    opts = {
      indent = { enabled = false }, -- Snacksプラグインのインデントを無効化
    },
  },
}
