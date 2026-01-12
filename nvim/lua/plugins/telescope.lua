return {
  "nvim-telescope/telescope-file-browser.nvim",
  dependencies = {
    "nvim-telescope/telescope.nvim",
    "nvim-lua/plenary.nvim",
  },

  -- We want to replace netrw on startup.
  lazy = false,
  config = function ()
    local picker_config = {
      -- show hidden dirs like .github, .cargo, but hide .git
      hidden = true,
      file_ignore_patterns = {
        "^%.git/",
      },
    }

    local telescope = require("telescope")
    telescope.setup{
      defaults = {
        path_display = { "smart" },
      },
      pickers = {
        find_files = picker_config,
        live_grep = picker_config,
      },
      extensions = {
        file_browser = {
          hijack_netrw = true,
          -- Start at current buffer.
          path = "%:p:h",
          select_buffer = true,

          -- Folders before files.
          grouped = true,

          hidden = {
            file_browser = true,
            folder_browser = true,
          },
        },
      },
    }

    telescope.load_extension("file_browser")
  end,

  keys = {
    { "<Leader>ff", "<cmd>Telescope find_files<cr>" },
    { "<Leader>fg", "<cmd>Telescope live_grep<cr>" },
    { "<Leader>fm", "<cmd>Telescope file_browser<cr>" },
  },
}
