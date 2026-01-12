-- Line numbering.
vim.o.nu = true
vim.o.rnu = true

-- Indentation.
vim.o.sw = 2
vim.o.et = true
vim.o.si = true

vim.o.clipboard = "unnamedplus"

vim.o.undofile = true
vim.o.undodir = os.getenv("HOME") .. "/.vim/undodir"

-- Line wrapping.
vim.o.cc = "100"
vim.o.wrap = false

vim.g.mapleader = " "
vim.g.maplocalleader = ","

vim.o.background = "dark"

vim.cmd.colorscheme "retrobox"

