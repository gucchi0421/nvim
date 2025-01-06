return {
  {
    "kdheepak/lazygit.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "akinsho/toggleterm.nvim",
    },
  },
  {
    "f-person/git-blame.nvim",
    event = "VeryLazy",
    opts = {
      enabled = true,
      message_template = " <author> / <summary> / <date>",
      date_format = "%Y-%m-%d %H:%M",
      virtual_text_column = 1,
    },
  },
}
