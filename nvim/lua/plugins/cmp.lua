return {
  "hrsh7th/nvim-cmp",
  dependencies = {
    -- Snippet helper.
    "hrsh7th/vim-vsnip",
    "hrsh7th/cmp-vsnip",

    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-nvim-lsp-signature-help",
    "hrsh7th/cmp-path",
    "hrsh7th/cmp-cmdline",
  },

  lazy = false,
  config = function ()
    local cmp = require("cmp")

    -- Don't confirm for signature help to allow new line without selecting argument name.
    local cmp_confirm = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Replace,
      select = false,
    })
    local confirm = cmp.sync(function (fallback)
      if e and e.source_name == "nvim_lsp_signature_help" then
        fallback()
      else
        cmp_confirm(fallback)
      end
    end)

    cmp.setup{
      snippet = {
        expand = function (args) vim.fn["vsnip#anonymous"](args.body) end,
      },
      mapping = cmp.mapping.preset.insert({
        ["<C-space>"] = cmp.mapping.complete(),

        ["<C-b>"] = cmp.mapping.scroll_docs(-4),
        ["<C-f>"] = cmp.mapping.scroll_docs(4),

        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<CR>"] = confirm,
      }),

      -- Sources are specified as a list of lists, each of which is tried in order.
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "nvim_lsp_signature_help" },
        { name = "vsnip" },
      }, {
        { name = "path" },
      }, {
        { name = "buffer" },
      }),
    }

    -- grep words from file.
    cmp.setup.cmdline({ "/", "?" }, {
      mapping = cmp.mapping.preset.cmdline(),
      sources = {
        { name = "buffer" },
      },
    })

    cmp.setup.cmdline(":", {
      mapping = cmp.mapping.preset.cmdline(),
      sources = cmp.config.sources({
        { name = "cmdline" },
      }, {
        { name = "path" },
      }),
    })
  end,
}
