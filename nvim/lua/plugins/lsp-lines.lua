-- lsp_lines: nicer inline diagnostics

return {
  "https://git.sr.ht/~whynothugo/lsp_lines.nvim",
  event = "LspAttach",
  config = function ()
    require("lsp_lines").setup()

    vim.diagnostic.config({
      virtual_lines = true,
      virtual_text = false, -- Disable builtin diagnostics.
    })
  end,
}
