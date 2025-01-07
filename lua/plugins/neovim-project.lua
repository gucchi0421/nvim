return {
  {
    "coffebar/neovim-project",
    opts = {
      projects = { -- define project roots
        "~/documents/functions/*",
        "~/documents/templates/*",
        "~/documents/services/*",
        "~/documents/tools/*",
        "~/documents/workspace/*/*",
        "~/documents/works/*",
        "~/documents/zenn/*",
        "~/.config/nvim/",
      },
      picker = {
        type = "telescope", -- or "fzf-lua"
      },
      last_session_on_startup = true,
      filetype_autocmd_timeout = 200,
    },
    init = function()
      vim.opt.sessionoptions:append("globals")
    end,
    dependencies = {
      { "nvim-lua/plenary.nvim" },
      { "nvim-telescope/telescope.nvim", tag = "0.1.4" },
      { "ibhagwan/fzf-lua" },
      { "Shatur/neovim-session-manager" },
    },
    lazy = false,
    priority = 100,
  },
}
