-- nvim-treesitter: Treesitter parsers and syntax highlighting

return {
  "nvim-treesitter/nvim-treesitter",
  lazy = false,
  build = ":TSUpdate",
  config = function ()
    require("nvim-treesitter").install{
      "c",
      "vim",
      "vimdoc",
      "cpp",
      "nix",
      "lua",
      "html",
      "css",
      "scss",
      "javascript",
      "typescript",
      "json",
      "python",
      "matlab",
      "csv",
      "xml",
      "yaml",
      "rust",
      "toml",
      "markdown",
      "markdown_inline",
      "latex",
    }

    vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
      callback = function (args)
        vim.treesitter.start(args.buf)
        vim.bo.syntax = "ON" -- Retain regex highlighting where needed.
      end,
    })
  end,
}
