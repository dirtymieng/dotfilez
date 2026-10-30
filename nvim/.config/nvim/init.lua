vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("options")
require("keymaps")
require("plugins")
require("lsp")

-- Per-machine settings: lua/local.lua, not in git (see .gitignore)
pcall(require, "local")
