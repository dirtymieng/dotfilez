local map = vim.keymap.set

-- Window navigation
map("n", "<C-h>", "<C-w>h", { desc = "Move to left window" })
map("n", "<C-j>", "<C-w>j", { desc = "Move to lower window" })
map("n", "<C-k>", "<C-w>k", { desc = "Move to upper window" })
map("n", "<C-l>", "<C-w>l", { desc = "Move to right window" })

-- Window resizing
map("n", "<C-Up>",    ":resize -2<CR>",          { silent = true })
map("n", "<C-Down>",  ":resize +2<CR>",          { silent = true })
map("n", "<C-Left>",  ":vertical resize -2<CR>", { silent = true })
map("n", "<C-Right>", ":vertical resize +2<CR>", { silent = true })

-- Buffer navigation
map("n", "<S-l>", ":bnext<CR>",     { silent = true, desc = "Next buffer" })
map("n", "<S-h>", ":bprevious<CR>", { silent = true, desc = "Prev buffer" })
map("n", "<leader>bd", ":bdelete<CR>", { silent = true, desc = "Delete buffer" })

-- Stay in indent mode when indenting in visual
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Move lines up/down
map("n", "<A-j>", ":m .+1<CR>==",        { silent = true })
map("n", "<A-k>", ":m .-2<CR>==",        { silent = true })
map("v", "<A-j>", ":m '>+1<CR>gv=gv",   { silent = true })
map("v", "<A-k>", ":m '<-2<CR>gv=gv",   { silent = true })

-- Clear search highlight
map("n", "<leader>h", ":nohlsearch<CR>", { silent = true, desc = "Clear highlight" })

-- Quick save/quit
map("n", "<leader>w", ":w<CR>",  { silent = true, desc = "Save" })
map("n", "<leader>q", ":q<CR>",  { silent = true, desc = "Quit" })
map("n", "<leader>Q", ":qa!<CR>", { silent = true, desc = "Force quit all" })

-- Diagnostic navigation (set before LSP loads; works with built-in diagnostics)
map("n", "[d", vim.diagnostic.goto_prev,  { desc = "Prev diagnostic" })
map("n", "]d", vim.diagnostic.goto_next,  { desc = "Next diagnostic" })
map("n", "<leader>e", vim.diagnostic.open_float, { desc = "Open diagnostic float" })
map("n", "<leader>dl", vim.diagnostic.setloclist, { desc = "Diagnostics to loclist" })
