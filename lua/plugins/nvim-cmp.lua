return {
  {
    "hrsh7th/nvim-cmp",
    enabled = true,
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "saadparwaiz1/cmp_luasnip",
      "L3MON4D3/LuaSnip",
      "hrsh7th/cmp-emoji",
      "MeanderingProgrammer/render-markdown.nvim",
    },
    event = "InsertEnter",
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")
      cmp.setup({
        completion = {
          autocomplete = false,
          completeopt = "menu,menuone,noinsert",
        },
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = {
          { name = "nvim_lsp", trigger_characters = {} },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
          { name = "emoji" },
          { name = "render-markdown" },
        },
        formatting = {
          fields = { "abbr", "kind", "menu" }, -- 必要なフィールドを指定
          expandable_indicator = true, -- 必要に応じて設定（省略可能）
          format = function(entry, vim_item)
            vim_item.menu = ({
              nvim_lsp = "[LSP]",
              luasnip = "[SNIPPET]",
              buffer = "[BUFFER]",
              path = "[PATH]",
              emoji = "[EMOJI]",
            })[entry.source.name]
            return vim_item
          end,
        },
        mapping = cmp.mapping.preset.insert({
          ["<CR>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.confirm({ select = true }) -- 補完ウィンドウが表示されている場合のみ確定
            else
              fallback() -- 通常のEnter動作
            end
          end, { "i", "s" }),

          ["<C-CR>"] = cmp.mapping.confirm({ select = true }), -- Ctrl+Enterで補完確定
        }),
      })
    end,
  },
}
