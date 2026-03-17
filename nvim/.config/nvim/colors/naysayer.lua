-- naysayer.lua
-- Based on Jonathan Blow's Emacs color scheme ("Naysayer" after his YouTube channel)
-- Colors synthesized from stream footage and community ports:
--   https://vegard.wiki/w/Jon_Blow_emacs_colorscheme
--   https://github.com/nickav/naysayer-theme.el
--   https://github.com/pixlark/JonathanBlowEmacsTheme

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "naysayer"

-- ── Palette ───────────────────────────────────────────────────────────────────

local p = {
  -- Backgrounds
  bg          = { gui = "#052329", cterm = 23  }, -- dark teal-black (the signature bg)
  bg_line     = { gui = "#0b3335", cterm = 237 }, -- current line highlight
  bg_margin   = { gui = "#183848", cterm = 238 }, -- gutter / line number bg
  bg_sel      = { gui = "#0000FF", cterm = 21  }, -- selection (pure blue — very distinctive)

  -- Foregrounds
  fg          = { gui = "#D0C0A0", cterm = 180 }, -- warm tan/beige
  fg_subtle   = { gui = "#8C9C9A", cterm = 109 }, -- muted, for line numbers
  white       = { gui = "#FFFFFF", cterm = 231 }, -- keywords

  -- Syntax colors
  green_com   = { gui = "#40C040", cterm = 76  }, -- comments (bright green)
  teal_str    = { gui = "#40B0A0", cterm = 73  }, -- strings (teal)
  cyan_num    = { gui = "#80F0E0", cterm = 122 }, -- numbers / integer constants
  green_type  = { gui = "#8CDE94", cterm = 114 }, -- types, storage
  green_pre   = { gui = "#B0FFB0", cterm = 157 }, -- preprocessor / macros
  tan_bar     = { gui = "#D8B488", cterm = 180 }, -- statusline / bar

  -- Accents
  orange_srch = { gui = "#CD8B60", cterm = 173 }, -- isearch / search match
  red_err     = { gui = "#FF0000", cterm = 196 }, -- errors
  yellow_warn = { gui = "#FFBB00", cterm = 220 }, -- warnings
  green_add   = { gui = "#2ea040", cterm = 71  }, -- diff add
  red_del     = { gui = "#802020", cterm = 88  }, -- diff delete
  cursor_grn  = { gui = "#90C090", cterm = 108 }, -- cursor color
}

-- ── Helpers ───────────────────────────────────────────────────────────────────

local function hi(group, opts)
  local h = {}
  if opts.fg        then h.fg       = opts.fg.gui;  h.ctermfg = opts.fg.cterm end
  if opts.bg        then h.bg       = opts.bg.gui;  h.ctermbg = opts.bg.cterm end
  if opts.sp        then h.sp       = opts.sp.gui end
  if opts.bold      then h.bold      = true end
  if opts.italic    then h.italic    = true end
  if opts.underline then h.underline = true end
  if opts.undercurl then h.undercurl = true end
  vim.api.nvim_set_hl(0, group, h)
end

local function link(from, to)
  vim.api.nvim_set_hl(0, from, { link = to })
end

-- ── Syntax ────────────────────────────────────────────────────────────────────

hi("Normal",     { fg = p.fg,        bg = p.bg })
hi("Comment",    { fg = p.green_com })           -- bright green — very distinctive

hi("Constant",   { fg = p.cyan_num })
link("Number",     "Constant")
link("Float",      "Constant")
link("Boolean",    "Constant")
link("Character",  "Constant")
hi("String",     { fg = p.teal_str })            -- teal, separate from other constants

link("Identifier", "Normal")
link("Function",   "Normal")                     -- functions same as foreground

hi("Statement",  { fg = p.white })               -- keywords: plain white
link("Conditional", "Statement")
link("Repeat",      "Statement")
link("Label",       "Statement")
link("Keyword",     "Statement")
link("Exception",   "Statement")

link("Operator",    "Normal")

hi("PreProc",    { fg = p.green_pre })           -- very light green
link("Include",    "PreProc")
link("Define",     "PreProc")
link("Macro",      "PreProc")
link("PreCondit",  "PreProc")

hi("Type",       { fg = p.green_type })          -- light green
link("StorageClass", "Type")
link("Structure",    "Type")
link("Typedef",      "Type")

link("Special",        "Normal")
link("SpecialChar",    "Normal")
link("Tag",            "Normal")
link("Delimiter",      "Normal")
link("SpecialComment", "Comment")
link("Debug",          "Normal")

hi("Underlined",  { fg = p.fg,       underline = true })
hi("Ignore",      { fg = p.bg })
hi("Error",       { fg = p.white,    bg = p.red_err, bold = true })
hi("Todo",        { fg = p.green_com, bold = true })

-- ── UI ────────────────────────────────────────────────────────────────────────

hi("Cursor",       { fg = p.bg,         bg = p.cursor_grn })
hi("CursorLine",   { bg = p.bg_line })
hi("CursorColumn", { bg = p.bg_line })
hi("ColorColumn",  { bg = p.bg_line })

hi("LineNr",       { fg = p.fg_subtle,  bg = p.bg_margin })
hi("CursorLineNr", { fg = p.tan_bar,    bg = p.bg_margin, bold = true })
hi("SignColumn",   { fg = p.fg_subtle,  bg = p.bg_margin })
hi("FoldColumn",   { fg = p.fg_subtle,  bg = p.bg_margin })
hi("Folded",       { fg = p.fg_subtle,  bg = p.bg_margin })

hi("StatusLine",   { fg = p.bg,         bg = p.tan_bar })
hi("StatusLineNC", { fg = p.fg_subtle,  bg = p.bg_margin })
hi("VertSplit",    { fg = p.bg_margin,  bg = p.bg_margin })
hi("WinSeparator", { fg = p.bg_margin,  bg = p.bg_margin })

hi("Visual",       { fg = p.white,      bg = p.bg_sel })  -- pure blue selection
hi("VisualNOS",    { bg = p.bg_margin })

hi("Search",       { fg = p.bg,         bg = p.orange_srch })
hi("IncSearch",    { fg = p.bg,         bg = p.orange_srch, bold = true })

hi("Pmenu",        { fg = p.fg,         bg = p.bg_margin })
hi("PmenuSel",     { fg = p.white,      bg = p.bg_sel, bold = true })
hi("PmenuSbar",    { bg = p.bg_margin })
hi("PmenuThumb",   { bg = p.fg_subtle })

hi("TabLine",      { fg = p.fg_subtle,  bg = p.bg_margin })
hi("TabLineSel",   { fg = p.bg,         bg = p.tan_bar, bold = true })
hi("TabLineFill",  { bg = p.bg_margin })

hi("MatchParen",   { fg = p.white,      bg = p.bg_sel, bold = true })

hi("NonText",      { fg = p.bg_margin })
hi("SpecialKey",   { fg = p.bg_margin })
hi("Directory",    { fg = p.green_type })
hi("Title",        { fg = p.tan_bar,    bold = true })
hi("WildMenu",     { fg = p.bg,         bg = p.tan_bar })
hi("MoreMsg",      { fg = p.green_com })
link("ModeMsg",    "MoreMsg")
hi("Question",     { fg = p.green_com })
hi("ErrorMsg",     { fg = p.red_err })
hi("WarningMsg",   { fg = p.yellow_warn })
hi("qfLineNr",     { fg = p.fg_subtle })

hi("DiffAdd",      { fg = p.green_add })
hi("DiffDelete",   { fg = p.red_del })
hi("DiffChange",   { fg = p.yellow_warn })
hi("DiffText",     { fg = p.cyan_num })

hi("SpellBad",     { undercurl = true,  sp = p.red_err })
hi("SpellCap",     { undercurl = true,  sp = p.cyan_num })
hi("SpellRare",    { undercurl = true,  sp = p.yellow_warn })
hi("SpellLocal",   { undercurl = true,  sp = p.green_com })

-- ── LSP / Diagnostics ─────────────────────────────────────────────────────────

hi("DiagnosticError",          { fg = p.red_err })
hi("DiagnosticWarn",           { fg = p.yellow_warn })
hi("DiagnosticInfo",           { fg = p.cyan_num })
hi("DiagnosticHint",           { fg = p.fg_subtle })
hi("DiagnosticUnderlineError", { undercurl = true, sp = p.red_err })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.yellow_warn })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = p.cyan_num })
