return {
  "SmiteshP/nvim-navic",
  dependencies = "neovim/nvim-lspconfig",
  init = function()
    -- LSPがアタッチされた時の処理を追加
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client.server_capabilities.documentSymbolProvider then
          require("nvim-navic").attach(client, args.buf)
        end
      end,
    })
  end,
  opts = {
    icons = {
      File = "󰈙 ",
      Module = " ",
      Namespace = "󰌗 ",
      Package = " ",
      Class = "󰌗 ",
      Method = "󰆧 ",
      Property = " ",
      Field = " ",
      Constructor = " ",
      Enum = "󰕘",
      Interface = "󰕘",
      Function = "󰊕 ",
      Variable = "󰆧 ",
      Constant = "󰏿 ",
      String = "󰀬 ",
      Number = "󰎠 ",
      Boolean = "◩ ",
      Array = "󰅪 ",
      Object = "󰅩 ",
      Key = "󰌋 ",
      Null = "󰟢 ",
      EnumMember = " ",
      Struct = "󰌗 ",
      Event = " ",
      Operator = "󰆕 ",
      TypeParameter = "󰊄 ",
    },
    highlight = true,
    separator = " > ",
    depth_limit = 0,
    depth_limit_indicator = "..",
    lsp = {
      auto_attach = true,
      preference = nil,
    },
    safe_output = true,
    lazy_update_context = false,
    click = false,
    format_text = function(text)
      return text
    end,
  },
}
