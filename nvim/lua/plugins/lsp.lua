-- LSP configuration.

return {
  -- Prefab configurations for most language servers.
  "neovim/nvim-lspconfig",

  lazy = false,
  config = function ()
    vim.lsp.enable("nil_ls") -- Nix.
    vim.lsp.enable("ts_ls") -- Javascript.
    vim.lsp.enable("clangd") -- C/C++.

    vim.lsp.enable("jdtls") -- Java.

    vim.lsp.enable("html")
    vim.lsp.enable("cssls")
    vim.lsp.enable("emmet_language_server")

    vim.lsp.enable("gdscript")

    vim.lsp.config("rust_analyzer", {
      settings = {
        ["rust-analyzer"] = {
          check = {
            ignore = {
              "dead_code",
            },
          },
        },
      },
    })
    vim.lsp.enable("rust_analyzer")

    vim.lsp.enable("texlab") -- LaTeX.
    vim.lsp.enable("pyright") -- Python.
  end,

  -- Replace builtin goto definition with LSP.
  keys = {
    { "gd", vim.lsp.buf.definition },
    { "<Leader>ca", vim.lsp.buf.code_action },
  },
}
