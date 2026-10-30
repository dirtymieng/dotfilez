-- Doom Emacs (evil) default keymaps. SPC is leader; which-key shows the menus.
local map = vim.keymap.set

local function fzf(cmd, opts)
  return function() require("fzf-lua")[cmd](opts or {}) end
end

-- Project root = nearest .git above the current file (falls back to cwd)
local function project_root()
  return vim.fs.root(0, ".git") or vim.uv.cwd()
end

local function buffer_dir()
  return vim.fn.expand("%:p:h")
end

-- ── Escape ────────────────────────────────────────────────────────────────────
map("i", "jk", "<Esc>", { desc = "Escape" })                  -- evil-escape
map("n", "<Esc>", "<cmd>nohlsearch<cr><Esc>", { desc = "Clear highlight" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Leave terminal mode" })

-- ── Top level ─────────────────────────────────────────────────────────────────
map("n", "<leader><leader>", function() require("fzf-lua").files({ cwd = project_root() }) end,
  { desc = "Find file in project" })
map("n", "<leader>.", function() require("fzf-lua").files({ cwd = buffer_dir() }) end,
  { desc = "Find file" })
map("n", "<leader>,", fzf("buffers"),  { desc = "Switch buffer" })
map("n", "<leader>/", function() require("fzf-lua").live_grep({ cwd = project_root() }) end,
  { desc = "Search project" })
map("n", "<leader>:", fzf("commands"), { desc = "Commands (M-x)" })
map("n", "<leader>'", fzf("resume"),   { desc = "Resume last search" })
map("n", "<leader>-", "<cmd>Oil<cr>",  { desc = "Dired (oil)" })
map("n", "-",         "<cmd>Oil<cr>",  { desc = "Parent directory" })

-- ── b: buffers ────────────────────────────────────────────────────────────────
map("n", "<leader>bb", fzf("buffers"),       { desc = "Switch buffer" })
map("n", "<leader>bk", "<cmd>bdelete<cr>",   { desc = "Kill buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>",   { desc = "Kill buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>b]", "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "<leader>b[", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bN", "<cmd>enew<cr>",      { desc = "New empty buffer" })
map("n", "<leader>bs", "<cmd>write<cr>",     { desc = "Save buffer" })
map("n", "<leader>bS", "<cmd>wall<cr>",      { desc = "Save all buffers" })
map("n", "]b", "<cmd>bnext<cr>",     { desc = "Next buffer" })
map("n", "[b", "<cmd>bprevious<cr>", { desc = "Previous buffer" })

-- ── f: files ──────────────────────────────────────────────────────────────────
map("n", "<leader>ff", function() require("fzf-lua").files({ cwd = buffer_dir() }) end,
  { desc = "Find file" })
map("n", "<leader>fr", fzf("oldfiles"),  { desc = "Recent files" })
map("n", "<leader>fs", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>fS", ":saveas ",       { desc = "Save file as" })
map("n", "<leader>fy", function()
  local path = vim.fn.expand("%:p")
  vim.fn.setreg("+", path)
  vim.notify("Copied " .. path)
end, { desc = "Yank file path" })
map("n", "<leader>fp", function() require("fzf-lua").files({ cwd = vim.fn.stdpath("config") }) end,
  { desc = "Find file in private config" })

-- ── p: project ────────────────────────────────────────────────────────────────
map("n", "<leader>pf", function() require("fzf-lua").files({ cwd = project_root() }) end,
  { desc = "Find file in project" })
map("n", "<leader>ps", function() require("fzf-lua").live_grep({ cwd = project_root() }) end,
  { desc = "Search project" })

-- ── s: search ─────────────────────────────────────────────────────────────────
map("n", "<leader>ss", fzf("blines"), { desc = "Search buffer" })
map("n", "<leader>sb", fzf("blines"), { desc = "Search buffer" })
map("n", "<leader>sp", function() require("fzf-lua").live_grep({ cwd = project_root() }) end,
  { desc = "Search project" })
map("n", "<leader>sd", function() require("fzf-lua").live_grep({ cwd = buffer_dir() }) end,
  { desc = "Search directory" })
map("n", "<leader>si", fzf("lsp_document_symbols"), { desc = "Jump to symbol" })
map("n", "<leader>sr", fzf("marks"),                { desc = "Jump to mark" })
map("n", "<leader>sw", fzf("grep_cword"),           { desc = "Search word under cursor" })

-- ── w: windows (like Doom's evil-window-map) ──────────────────────────────────
map("n", "<leader>wh", "<C-w>h", { desc = "Window left" })
map("n", "<leader>wj", "<C-w>j", { desc = "Window down" })
map("n", "<leader>wk", "<C-w>k", { desc = "Window up" })
map("n", "<leader>wl", "<C-w>l", { desc = "Window right" })
map("n", "<leader>wH", "<C-w>H", { desc = "Move window left" })
map("n", "<leader>wJ", "<C-w>J", { desc = "Move window down" })
map("n", "<leader>wK", "<C-w>K", { desc = "Move window up" })
map("n", "<leader>wL", "<C-w>L", { desc = "Move window right" })
map("n", "<leader>wv", "<C-w>v", { desc = "Split vertically" })
map("n", "<leader>ws", "<C-w>s", { desc = "Split horizontally" })
map("n", "<leader>ww", "<C-w>w", { desc = "Other window" })
map("n", "<leader>wd", "<C-w>c", { desc = "Delete window" })
map("n", "<leader>wc", "<C-w>c", { desc = "Delete window" })
map("n", "<leader>wo", "<C-w>o", { desc = "Delete other windows" })
map("n", "<leader>w=", "<C-w>=", { desc = "Balance windows" })
map("n", "<leader>wx", "<C-w>x", { desc = "Swap with next window" })

-- Ctrl+hjkl window moves (kept from the old config)
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

-- ── TAB: workspaces (as tabs) ─────────────────────────────────────────────────
map("n", "<leader><tab><tab>", "<cmd>tabs<cr>",        { desc = "List workspaces" })
map("n", "<leader><tab>n",     "<cmd>tabnew<cr>",      { desc = "New workspace" })
map("n", "<leader><tab>d",     "<cmd>tabclose<cr>",    { desc = "Delete workspace" })
map("n", "<leader><tab>]",     "<cmd>tabnext<cr>",     { desc = "Next workspace" })
map("n", "<leader><tab>[",     "<cmd>tabprevious<cr>", { desc = "Previous workspace" })
for i = 1, 9 do
  map("n", "<leader><tab>" .. i, "<cmd>tabnext " .. i .. "<cr>", { desc = "Workspace " .. i })
end

-- ── c: code (LSP-only maps are added per buffer in lsp.lua) ───────────────────
map("n", "<leader>cx", fzf("diagnostics_workspace"), { desc = "List errors" })
map("n", "<leader>cX", fzf("diagnostics_document"),  { desc = "List errors in buffer" })
map("n", "<leader>ce", vim.diagnostic.open_float,    { desc = "Show error at point" })

-- Errors: ]e / [e like Doom (]d / [d are git hunks, see plugins/init.lua)
map("n", "]e", function() vim.diagnostic.jump({ count = 1, float = true }) end,  { desc = "Next error" })
map("n", "[e", function() vim.diagnostic.jump({ count = -1, float = true }) end, { desc = "Previous error" })

-- ── g: git ────────────────────────────────────────────────────────────────────
map("n", "<leader>gg", "<cmd>Neogit<cr>",                { desc = "Neogit status (magit)" })
map("n", "<leader>gs", "<cmd>Gitsigns stage_hunk<cr>",   { desc = "Stage hunk" })
map("n", "<leader>gr", "<cmd>Gitsigns reset_hunk<cr>",   { desc = "Revert hunk" })
map("n", "<leader>gS", "<cmd>Gitsigns stage_buffer<cr>", { desc = "Stage file" })
map("n", "<leader>gR", "<cmd>Gitsigns reset_buffer<cr>", { desc = "Revert file" })
map("n", "<leader>gB", "<cmd>Gitsigns blame<cr>",        { desc = "Blame" })
map("n", "<leader>gb", fzf("git_branches"),              { desc = "Switch branch" })
map("n", "<leader>gl", fzf("git_commits"),               { desc = "Log" })
map("n", "<leader>gL", fzf("git_bcommits"),              { desc = "Log for file" })

-- ── o: open ───────────────────────────────────────────────────────────────────
map("n", "<leader>o-", "<cmd>Oil<cr>", { desc = "Dired (oil)" })
map("n", "<leader>ot", "<cmd>botright split | resize 15 | terminal<cr>", { desc = "Terminal popup" })
map("n", "<leader>oT", "<cmd>terminal<cr>", { desc = "Terminal here" })

-- ── t: toggle ─────────────────────────────────────────────────────────────────
map("n", "<leader>tl", function()
  vim.wo.number = not vim.wo.number
  vim.wo.relativenumber = vim.wo.number
end, { desc = "Line numbers" })
map("n", "<leader>tw", function() vim.wo.wrap = not vim.wo.wrap end,   { desc = "Soft line wrap" })
map("n", "<leader>ts", function() vim.wo.spell = not vim.wo.spell end, { desc = "Spell check" })

-- ── h: help ───────────────────────────────────────────────────────────────────
map("n", "<leader>hh", fzf("helptags"),     { desc = "Search help" })
map("n", "<leader>hk", fzf("keymaps"),      { desc = "Describe key" })
map("n", "<leader>ht", fzf("colorschemes"), { desc = "Load theme" })
map("n", "<leader>hm", fzf("manpages"),     { desc = "Man pages" })

-- ── q: quit ───────────────────────────────────────────────────────────────────
map("n", "<leader>qq", "<cmd>confirm qall<cr>", { desc = "Quit" })
map("n", "<leader>qQ", "<cmd>qall!<cr>",        { desc = "Quit without saving" })

-- ── Editing (kept from the old config) ────────────────────────────────────────
map("v", "<", "<gv")
map("v", ">", ">gv")
map("n", "<A-j>", "<cmd>m .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", "<cmd>m .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":m '>+1<cr>gv=gv", { silent = true, desc = "Move lines down" })
map("v", "<A-k>", ":m '<-2<cr>gv=gv", { silent = true, desc = "Move lines up" })
map("n", "<C-Up>",    "<cmd>resize -2<cr>")
map("n", "<C-Down>",  "<cmd>resize +2<cr>")
map("n", "<C-Left>",  "<cmd>vertical resize -2<cr>")
map("n", "<C-Right>", "<cmd>vertical resize +2<cr>")
