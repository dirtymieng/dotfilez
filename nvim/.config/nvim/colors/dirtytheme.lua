-- dirtytheme.lua
-- Ported from paramount.vim (original by github.com/owickstrom)

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "dirtytheme"

-- ── Palette ───────────────────────────────────────────────────────────────────

local p = {
  black         = { gui = "#000000", cterm = 232 },
  medium_gray   = { gui = "#767676", cterm = 243 },
  kinda_gray    = { gui = "#bcbcbc", cterm = 250 },
  white         = { gui = "#F1F1F1", cterm = 15  },
  actual_white  = { gui = "#FFFFFF", cterm = 231 },
  subtle_black  = { gui = "#303030", cterm = 236 },
  light_black   = { gui = "#262626", cterm = 235 },
  lighter_black = { gui = "#4E4E4E", cterm = 239 },
  light_gray    = { gui = "#A8A8A8", cterm = 248 },
  lighter_gray  = { gui = "#C6C6C6", cterm = 251 },
  lightest_gray = { gui = "#EEEEEE", cterm = 253 },
  pink          = { gui = "#fb007a", cterm = 9   },
  dark_red      = { gui = "#C30771", cterm = 1   },
  light_red     = { gui = "#E32791", cterm = 1   },
  orange        = { gui = "#D75F5F", cterm = 167 },
  darker_blue   = { gui = "#005F87", cterm = 18  },
  dark_blue     = { gui = "#008EC4", cterm = 32  },
  blue          = { gui = "#20BBFC", cterm = 12  },
  light_blue    = { gui = "#b6d6fd", cterm = 153 },
  dark_cyan     = { gui = "#20A5BA", cterm = 6   },
  light_cyan    = { gui = "#4FB8CC", cterm = 14  },
  dark_green    = { gui = "#718C00", cterm = 64  },
  light_green   = { gui = "#5FD7A7", cterm = 10  },
  dark_purple   = { gui = "#af5fd7", cterm = 134 },
  light_purple  = { gui = "#a790d5", cterm = 140 },
  yellow        = { gui = "#F3E430", cterm = 11  },
  light_yellow  = { gui = "#ffff87", cterm = 228 },
  dark_yellow   = { gui = "#A89C14", cterm = 3   },
  dark_khaki    = { gui = "#878700", cterm = 100 },
}

-- ── Dark / light variants ─────────────────────────────────────────────────────

local bg, bg_subtle, bg_very_subtle
local norm, norm_subtle
local purple, green, red, visual, yellow

if vim.o.background == "dark" then
  bg            = p.black
  bg_subtle     = p.lighter_black
  bg_very_subtle = p.subtle_black
  norm          = p.lighter_gray
  norm_subtle   = p.medium_gray
  purple        = p.light_purple
  green         = p.light_green
  red           = p.light_red
  visual        = p.light_purple
  yellow        = p.light_yellow
else
  bg            = p.kinda_gray
  bg_subtle     = p.light_gray
  bg_very_subtle = p.lightest_gray
  norm          = p.light_black
  norm_subtle   = p.medium_gray
  purple        = p.dark_purple
  green         = p.dark_green
  red           = p.dark_red
  visual        = p.dark_purple
  yellow        = p.dark_yellow
end

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

-- ── Syntax groups ─────────────────────────────────────────────────────────────

hi("Normal",       { fg = norm,          bg = bg })
hi("Cursor",       { fg = norm,          bg = purple })
hi("Comment",      { fg = bg_subtle,     bg = bg_very_subtle, italic = true })

hi("Constant",     { fg = purple })
link("Character",  "Constant")
link("Number",     "Constant")
link("Boolean",    "Constant")
link("Float",      "Constant")
link("String",     "Constant")

link("Identifier", "Normal")
link("Function",   "Identifier")

hi("Statement",    { fg = p.dark_khaki })
link("Conditional", "Statement")
link("Repeat",     "Statement")
link("Label",      "Statement")
link("Keyword",    "Statement")
link("Exception",  "Statement")

hi("Operator",     { fg = norm,          bold = true })

hi("PreProc",      { fg = norm_subtle })
link("Include",    "PreProc")
link("Define",     "PreProc")
link("Macro",      "PreProc")
link("PreCondit",  "PreProc")

hi("Type",         { fg = norm })
link("StorageClass", "Type")
link("Structure",  "Type")
link("Typedef",    "Type")

hi("Special",      { fg = norm_subtle,   italic = true })
link("SpecialChar",    "Special")
link("Tag",            "Special")
link("Delimiter",      "Special")
link("SpecialComment", "Special")
link("Debug",          "Special")

hi("Underlined",   { fg = norm,          underline = true })
hi("Ignore",       { fg = bg })
hi("Error",        { fg = p.actual_white, bg = red, bold = true })
hi("Todo",         { fg = purple,        underline = true })

-- ── UI groups ─────────────────────────────────────────────────────────────────

hi("SpecialKey",   { fg = p.light_green })
hi("NonText",      { fg = p.medium_gray })
hi("Directory",    { fg = p.dark_blue })
hi("ErrorMsg",     { fg = red })
hi("IncSearch",    { fg = p.light_black, bg = yellow })
hi("Search",       { fg = p.light_black, bg = p.light_green })
hi("MoreMsg",      { fg = p.medium_gray, bold = true })
link("ModeMsg",    "MoreMsg")
hi("LineNr",       { fg = bg_subtle })
hi("CursorLineNr", { fg = purple,        bg = bg_very_subtle })
hi("Question",     { fg = red })
hi("StatusLine",   { fg = p.light_black, bg = bg_very_subtle })
hi("StatusLineNC", { fg = p.medium_gray })
hi("VertSplit",    { fg = p.medium_gray })
hi("Title",        { fg = p.dark_blue })
hi("Visual",       { fg = norm,          bg = visual })
hi("VisualNOS",    { bg = bg_subtle })
hi("WarningMsg",   { fg = yellow })
hi("WildMenu",     { fg = bg,            bg = norm })
hi("Folded",       { fg = p.medium_gray })
hi("FoldColumn",   { fg = bg_subtle })
hi("DiffAdd",      { fg = green })
hi("DiffDelete",   { fg = red })
hi("DiffChange",   { fg = p.dark_yellow })
hi("DiffText",     { fg = p.dark_blue })
hi("SignColumn",   { fg = p.light_green })

-- Spell: undercurl + sp color (better than cterm underline in Neovim)
hi("SpellBad",     { undercurl = true,   sp = red })
hi("SpellCap",     { undercurl = true,   sp = p.light_green })
hi("SpellRare",    { undercurl = true,   sp = p.pink })
hi("SpellLocal",   { undercurl = true,   sp = p.dark_green })

hi("Pmenu",        { fg = norm,          bg = bg_subtle })
hi("PmenuSel",     { fg = norm,          bg = purple })
hi("PmenuSbar",    { fg = norm,          bg = bg_subtle })
hi("PmenuThumb",   { fg = norm,          bg = bg_subtle })
hi("TabLine",      { fg = norm,          bg = bg_very_subtle })
hi("TabLineSel",   { fg = purple,        bg = bg_subtle, bold = true })
hi("TabLineFill",  { fg = norm,          bg = bg_very_subtle })
hi("CursorColumn", { bg = bg_very_subtle })
hi("CursorLine",   { bg = bg_very_subtle })
hi("ColorColumn",  { bg = bg_subtle })
hi("MatchParen",   { fg = norm,          bg = bg_subtle })
hi("qfLineNr",     { fg = p.medium_gray })

-- ── Filetype groups ───────────────────────────────────────────────────────────

for i = 1, 6 do
  hi("htmlH" .. i, { fg = norm, bg = bg })
end
