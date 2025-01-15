return {
  "nvim-neo-tree/neo-tree.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  config = function()
    require("neo-tree").setup({
      close_if_last_window = true,
      popup_border_style = "rounded",
      enable_git_status = true,
      enable_diagnostics = true,
      event_handlers = {
        {
          event = "file_opened",
          handler = function()
            -- return require("neo-tree").close_all()
          end,
        },
        {
          event = "file_added",
          handler = function(file_path)
            require("neo-tree.sources.manager").refresh("filesystem")
          end,
        },
      },
      use_libuv_file_watcher = true,
      filesystem = {
        filtered_items = {
          visible = true,
          hide_dotfiles = false,
          hide_gitignored = false,
        },
        follow_current_file = {
          enabled = true,
          leave_dirs_open = true,
        },
        group_empty_dirs = false,
        hijack_netrw_behavior = "open_current",
        scan_mode = "deep",
        use_watchfile = true,
        watch_dir = true,
        watch_timeout = 100,
      },
      window = {
        position = "left",
        width = 32,
      },
      source_selector = {
        winbar = true,
        content_layout = "center",
        sources = {
          { source = "filesystem" },
          { source = "buffers" },
          { source = "git_status" },
        },
      },
    })

    -- 背景透過の設定
    vim.cmd([[ highlight NeoTreeNormal guibg=NONE ctermbg=NONE ]])
    vim.cmd([[ highlight NeoTreeEndOfBuffer guibg=NONE ctermbg=NONE ]])
    vim.cmd([[ highlight NeoTreeWinSeparator guibg=NONE ctermbg=NONE ]])

    vim.api.nvim_create_autocmd("User", {
      pattern = "GoTestAdd",
      callback = function()
        vim.defer_fn(function()
          require("neo-tree.sources.manager").refresh("filesystem")
        end, 100)
      end,
    })
  end,
}
