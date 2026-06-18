local opt = vim.opt

-- Line numbers
opt.number = true
opt.relativenumber = true

-- Tabs / indentation (override per filetype in after/ftplugin/ if needed)
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smartindent = true

-- Appearance
opt.wrap = false
opt.cursorline = true
opt.termguicolors = true
opt.signcolumn = "yes"   -- always show; prevents layout shifts
opt.scrolloff = 8
opt.sidescrolloff = 8

-- Search
opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true

-- Splits
opt.splitright = true
opt.splitbelow = true

-- Performance / UX
opt.updatetime = 250     -- faster CursorHold (LSP highlights, diagnostics)
opt.timeoutlen = 300
opt.undofile = true      -- persistent undo across sessions
opt.swapfile = false
opt.backup = false

-- Clipboard: use system clipboard
opt.clipboard = "unnamedplus"

vim.o.background = "dark"
vim.cmd.colorscheme("zig")

-- Better completion menu
opt.completeopt = { "menu", "menuone", "noselect" }
