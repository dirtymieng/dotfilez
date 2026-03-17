-- plan9.lua
-- Inspired by the Acme editor from Plan 9 (Bell Labs)
-- Pale yellow body, pale blue UI chrome, minimal syntax emphasis.

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "plan9"

-- ── Palette ───────────────────────────────────────────────────────────────────
-- Colors drawn from Acme's actual source (plan9port/src/cmd/acme/cols.c)

local p = {
  -- Backgrounds
  yellow      = { gui = "#FFFFEA", cterm = 230 }, -- Acme body bg
  blue_tag    = { gui = "#EAFFFF", cterm = 195 }, -- Acme tag bar bg
  sel_body    = { gui = "#CCCCFF", cterm = 189 }, -- body selection
  sel_tag     = { gui = "#88AACC", cterm = 110 }, -- tag selection / subtle UI

  -- Foregrounds
  black       = { gui = "#000000", cterm = 0   },
  dark_gray   = { gui = "#555555", cterm = 240 }, -- comments, subtle text
  mid_gray    = { gui = "#999999", cterm = 246 }, -- very muted / non-text

  -- Accent (used sparingly — Plan 9 spirit)
  dark_blue   = { gui = "#00008B", cterm = 18  }, -- directories, links, keywords
  dark_red    = { gui = "#880000", cterm = 88  }, -- errors, deletion
  dark_green  = { gui = "#005500", cterm = 22  }, -- addition, ok
  dark_yellow = { gui = "#888800", cterm = 100 }, -- warnings, constants
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
-- Plan 9 editors have no syntax highlighting. We add just enough to be
-- useful without betraying the aesthetic.

hi("Normal",     { fg = p.black,     bg = p.yellow })
hi("Comment",    { fg = p.dark_gray, bg = p.yellow, italic = true })

-- Everything else is black by default — only a few groups get color.
hi("Constant",   { fg = p.dark_yellow })
link("Number",     "Constant")
link("Float",      "Constant")
link("Boolean",    "Constant")
link("Character",  "Constant")
link("String",     "Constant")

-- Identifiers and functions: plain black
link("Identifier", "Normal")
link("Function",   "Normal")

-- Keywords get dark blue — the only real "pop" of color
hi("Statement",  { fg = p.dark_blue })
link("Conditional", "Statement")
link("Repeat",      "Statement")
link("Label",       "Statement")
link("Keyword",     "Statement")
link("Exception",   "Statement")

link("Operator",   "Normal")
link("PreProc",    "Statement")
link("Include",    "Statement")
link("Define",     "Statement")
link("Macro",      "Statement")
link("PreCondit",  "Statement")

link("Type",        "Statement")
link("StorageClass","Statement")
link("Structure",   "Statement")
link("Typedef",     "Statement")

link("Special",        "Normal")
link("SpecialChar",    "Normal")
link("Tag",            "Normal")
link("Delimiter",      "Normal")
link("SpecialComment", "Comment")
link("Debug",          "Normal")

hi("Underlined",  { fg = p.black,    underline = true })
hi("Ignore",      { fg = p.yellow })
hi("Error",       { fg = p.yellow,   bg = p.dark_red, bold = true })
hi("Todo",        { fg = p.dark_blue, underline = true })

-- ── UI chrome ─────────────────────────────────────────────────────────────────
-- Tag bar / UI elements use the pale blue; body stays yellow.

hi("SpecialKey",   { fg = p.mid_gray })
hi("NonText",      { fg = p.mid_gray })
hi("Directory",    { fg = p.dark_blue })
hi("ErrorMsg",     { fg = p.dark_red })
hi("IncSearch",    { fg = p.black,    bg = p.sel_tag })
hi("Search",       { fg = p.black,    bg = p.sel_body })
hi("MoreMsg",      { fg = p.dark_gray })
link("ModeMsg",    "MoreMsg")

-- Line numbers in the muted tag-bar color
hi("LineNr",       { fg = p.mid_gray,   bg = p.blue_tag })
hi("CursorLineNr", { fg = p.black,      bg = p.blue_tag, bold = true })

hi("Question",     { fg = p.dark_blue })
hi("StatusLine",   { fg = p.black,      bg = p.sel_tag })  -- active: stronger blue
hi("StatusLineNC", { fg = p.dark_gray,  bg = p.blue_tag }) -- inactive: muted tag blue
hi("VertSplit",    { fg = p.sel_tag,    bg = p.blue_tag })
hi("WinSeparator", { fg = p.sel_tag,    bg = p.blue_tag })
hi("Title",        { fg = p.black,      bold = true })
hi("Visual",       { fg = p.black,      bg = p.sel_body })
hi("VisualNOS",    { fg = p.black,      bg = p.sel_tag })
hi("WarningMsg",   { fg = p.dark_yellow })
hi("WildMenu",     { fg = p.black,      bg = p.sel_tag })

hi("Folded",       { fg = p.dark_gray,  bg = p.blue_tag })
hi("FoldColumn",   { fg = p.mid_gray,   bg = p.blue_tag })
hi("SignColumn",   { fg = p.dark_gray,  bg = p.blue_tag })

hi("DiffAdd",      { fg = p.dark_green, bg = p.yellow })
hi("DiffDelete",   { fg = p.dark_red,   bg = p.yellow })
hi("DiffChange",   { fg = p.dark_yellow,bg = p.yellow })
hi("DiffText",     { fg = p.dark_blue,  bg = p.yellow })

hi("SpellBad",     { undercurl = true,  sp = p.dark_red })
hi("SpellCap",     { undercurl = true,  sp = p.dark_blue })
hi("SpellRare",    { undercurl = true,  sp = p.dark_yellow })
hi("SpellLocal",   { undercurl = true,  sp = p.dark_green })

-- Completion menu uses tag-bar blue
hi("Pmenu",        { fg = p.black,      bg = p.blue_tag })
hi("PmenuSel",     { fg = p.black,      bg = p.sel_body, bold = true })
hi("PmenuSbar",    { bg = p.blue_tag })
hi("PmenuThumb",   { bg = p.sel_tag })

hi("TabLine",      { fg = p.dark_gray,  bg = p.blue_tag })
hi("TabLineSel",   { fg = p.black,      bg = p.yellow,   bold = true })
hi("TabLineFill",  { bg = p.blue_tag })

hi("CursorLine",   { bg = p.blue_tag })
hi("CursorColumn", { bg = p.blue_tag })
hi("ColorColumn",  { bg = p.blue_tag })
hi("MatchParen",   { bg = p.sel_body,   bold = true })
hi("qfLineNr",     { fg = p.mid_gray })

-- LSP/diagnostic virtual text
hi("DiagnosticError",       { fg = p.dark_red })
hi("DiagnosticWarn",        { fg = p.dark_yellow })
hi("DiagnosticInfo",        { fg = p.dark_blue })
hi("DiagnosticHint",        { fg = p.dark_gray })
hi("DiagnosticUnderlineError", { undercurl = true, sp = p.dark_red })
hi("DiagnosticUnderlineWarn",  { undercurl = true, sp = p.dark_yellow })
hi("DiagnosticUnderlineInfo",  { undercurl = true, sp = p.dark_blue })
