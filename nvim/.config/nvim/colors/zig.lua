vim.cmd("hi clear")
if vim.fn.exists("syntax_on") == 1 then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "zig"

-- ── Palette ───────────────────────────────────────────────────────────────────
-- Extracted directly from ziglang.org stylesheet

local p = {
  -- light bg
  bg_light      = { gui = "#f8f8f8", cterm = 231 },
  bg_light_alt  = { gui = "#ffffff", cterm = 15  },

  -- dark bg
  bg_dark       = { gui = "#1e1e1e", cterm = 234 },
  bg_dark_page  = { gui = "#111111", cterm = 233 },

  -- foreground
  fg_light      = { gui = "#000000", cterm = 0   },
  fg_dark       = { gui = "#cccccc", cterm = 251 },
  fg_dark_dim   = { gui = "#bbbbbb", cterm = 250 },

  -- shared
  comment       = { gui = "#aaaa77", cterm = 143 },

  -- light syntax
  kw_light      = { gui = "#333333", cterm = 236 },
  str_light     = { gui = "#dd1144", cterm = 161 },
  builtin_light = { gui = "#0086b3", cterm = 31  },
  fn_light      = { gui = "#990000", cterm = 88  },
  num_light     = { gui = "#008080", cterm = 30  },
  type_light    = { gui = "#445588", cterm = 61  },

  -- dark syntax
  kw_dark       = { gui = "#eeeeee", cterm = 255 },
  str_dark      = { gui = "#22ee55", cterm = 83  },
  builtin_dark  = { gui = "#ff894c", cterm = 209 },
  fn_dark       = { gui = "#b1a0f8", cterm = 147 },
  num_dark      = { gui = "#ff8080", cterm = 210 },
  type_dark     = { gui = "#6688ff", cterm = 69  },

  -- ui accents
  blue_link     = { gui = "#2a6286", cterm = 24  },
  blue_link_dk  = { gui = "#8888ff", cterm = 105 },
  heading_light = { gui = "#666666", cterm = 242 },
  heading_dark  = { gui = "#cccccc", cterm = 251 },
  border        = { gui = "#666666", cterm = 242 },
  red           = { gui = "#dd1144", cterm = 161 },
  green         = { gui = "#22ee55", cterm = 83  },
  yellow        = { gui = "#aaaa00", cterm = 142 },
  orange        = { gui = "#ff894c", cterm = 209 },
  none          = nil,
}

-- ── Pick variant ──────────────────────────────────────────────────────────────

local bg, bg_alt, fg
local kw, str, builtin, fn, num, type_, heading

if vim.o.background == "dark" then
  bg      = p.bg_dark
  bg_alt  = p.bg_dark_page
  fg      = p.fg_dark
  kw      = p.kw_dark
  str     = p.str_dark
  builtin = p.builtin_dark
  fn      = p.fn_dark
  num     = p.num_dark
  type_   = p.type_dark
  heading = p.heading_dark
else
  bg      = p.bg_light
  bg_alt  = p.bg_light_alt
  fg      = p.fg_light
  kw      = p.kw_light
  str     = p.str_light
  builtin = p.builtin_light
  fn      = p.fn_light
  num     = p.num_light
  type_   = p.type_light
  heading = p.heading_light
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

-- ── Base syntax ───────────────────────────────────────────────────────────────

hi("Normal",        { fg = fg,      bg = bg })
hi("Comment",       { fg = p.comment, italic = true })

hi("Constant",      { fg = num })        -- .tok-null / .tok-number
hi("String",        { fg = str })        -- .tok-str
hi("Character",     { fg = str })
hi("Number",        { fg = num })
hi("Boolean",       { fg = num })
hi("Float",         { fg = num })

hi("Identifier",    { fg = fg })
hi("Function",      { fg = fn, bold = true })  -- .tok-fn

hi("Statement",     { fg = kw, bold = true })  -- .tok-kw
hi("Conditional",   { fg = kw, bold = true })
hi("Repeat",        { fg = kw, bold = true })
hi("Label",         { fg = kw, bold = true })
hi("Keyword",       { fg = kw, bold = true })
hi("Exception",     { fg = kw, bold = true })
hi("Operator",      { fg = fg })

hi("PreProc",       { fg = builtin })           -- .tok-builtin
hi("Include",       { fg = builtin })
hi("Define",        { fg = builtin })
hi("Macro",         { fg = builtin })
hi("PreCondit",     { fg = builtin })

hi("Type",          { fg = type_, bold = true }) -- .tok-type
hi("StorageClass",  { fg = type_, bold = true })
hi("Structure",     { fg = type_, bold = true })
hi("Typedef",       { fg = type_, bold = true })

hi("Special",       { fg = builtin })
hi("SpecialChar",   { fg = str })
hi("Delimiter",     { fg = fg })
hi("SpecialComment",{ fg = p.comment, bold = true })
hi("Debug",         { fg = num })

hi("Underlined",    { fg = fg, underline = true })
hi("Ignore",        { fg = bg })
hi("Error",         { fg = bg, bg = p.red, bold = true })
hi("Todo",          { fg = type_, bold = true, underline = true })

-- ── UI ────────────────────────────────────────────────────────────────────────

hi("Cursor",        { fg = bg,       bg = fn })
hi("CursorLine",    { bg = bg_alt })
hi("CursorColumn",  { bg = bg_alt })
hi("ColorColumn",   { bg = bg_alt })
hi("LineNr",        { fg = p.border })
hi("CursorLineNr",  { fg = fn,       bg = bg_alt, bold = true })
hi("SignColumn",    { fg = p.border, bg = bg })
hi("VertSplit",     { fg = p.border })
hi("WinSeparator",  { fg = p.border })

hi("StatusLine",    { fg = fg,       bg = bg_alt })
hi("StatusLineNC",  { fg = heading,  bg = bg_alt })

hi("Pmenu",         { fg = fg,       bg = bg_alt })
hi("PmenuSel",      { fg = bg,       bg = fn, bold = true })
hi("PmenuSbar",     { bg = bg_alt })
hi("PmenuThumb",    { bg = p.border })

hi("TabLine",       { fg = heading,  bg = bg_alt })
hi("TabLineSel",    { fg = fg,       bg = bg, bold = true })
hi("TabLineFill",   { bg = bg_alt })

hi("Visual",        { fg = bg,       bg = type_ })
hi("VisualNOS",     { bg = bg_alt })
hi("MatchParen",    { fg = fn,       bold = true })

hi("Search",        { fg = bg,       bg = num })
hi("IncSearch",     { fg = bg,       bg = fn })
hi("Substitute",    { fg = bg,       bg = fn })

hi("NonText",       { fg = p.border })
hi("SpecialKey",    { fg = p.border })
hi("Whitespace",    { fg = p.border })
hi("EndOfBuffer",   { fg = p.border })
hi("Directory",     { fg = builtin })

hi("Title",         { fg = heading,  bold = true })
hi("Question",      { fg = str,      bold = true })
hi("MoreMsg",       { fg = num })
hi("ModeMsg",       { fg = num })
hi("ErrorMsg",      { fg = str,      bold = true })
hi("WarningMsg",    { fg = p.orange })

hi("Folded",        { fg = p.comment,bg = bg_alt })
hi("FoldColumn",    { fg = p.comment,bg = bg })

hi("DiffAdd",       { fg = p.str_dark })
hi("DiffDelete",    { fg = str })
hi("DiffChange",    { fg = num })
hi("DiffText",      { fg = builtin })

hi("SpellBad",      { undercurl = true, sp = str })
hi("SpellCap",      { undercurl = true, sp = type_ })
hi("SpellRare",     { undercurl = true, sp = builtin })
hi("SpellLocal",    { undercurl = true, sp = num })

hi("WildMenu",      { fg = bg,       bg = fn })
hi("QuickFixLine",  { bg = bg_alt })
hi("qfLineNr",      { fg = p.border })

hi("FloatBorder",   { fg = p.border, bg = bg })
hi("NormalFloat",   { fg = fg,       bg = bg_alt })

-- ── Treesitter ────────────────────────────────────────────────────────────────

hi("@comment",              { fg = p.comment, italic = true })
hi("@keyword",              { fg = kw,        bold = true })
hi("@keyword.function",     { fg = kw,        bold = true })
hi("@keyword.return",       { fg = kw,        bold = true })
hi("@keyword.operator",     { fg = kw,        bold = true })
hi("@keyword.import",       { fg = builtin })
hi("@keyword.modifier",     { fg = kw,        bold = true })
hi("@conditional",          { fg = kw,        bold = true })
hi("@repeat",               { fg = kw,        bold = true })

hi("@string",               { fg = str })
hi("@string.escape",        { fg = str, bold = true })
hi("@character",            { fg = str })

hi("@number",               { fg = num })
hi("@float",                { fg = num })
hi("@boolean",              { fg = num })
hi("@constant.builtin",     { fg = num })   -- null, undefined, true, false

hi("@function",             { fg = fn,        bold = true })
hi("@function.call",        { fg = fn })
hi("@function.method",      { fg = fn,        bold = true })
hi("@function.method.call", { fg = fn })
hi("@constructor",          { fg = type_,     bold = true })

hi("@function.builtin",     { fg = builtin }) -- .tok-builtin
hi("@variable.builtin",     { fg = builtin })

hi("@type",                 { fg = type_,     bold = true })
hi("@type.builtin",         { fg = type_,     bold = true })
hi("@type.qualifier",       { fg = kw,        bold = true })

hi("@variable",             { fg = fg })
hi("@variable.parameter",   { fg = fg })
hi("@variable.member",      { fg = fg })

hi("@operator",             { fg = fg })
hi("@punctuation",          { fg = fg })
hi("@punctuation.delimiter",{ fg = fg })
hi("@punctuation.bracket",  { fg = fg })

hi("@label",                { fg = kw,        bold = true })
hi("@namespace",            { fg = type_ })
hi("@module",               { fg = type_ })
hi("@attribute",            { fg = builtin })

hi("@tag",                  { fg = kw,        bold = true })
hi("@tag.attribute",        { fg = type_ })
hi("@tag.delimiter",        { fg = fg })

-- ── LSP semantic tokens ───────────────────────────────────────────────────────

hi("@lsp.type.keyword",     { fg = kw,        bold = true })
hi("@lsp.type.string",      { fg = str })
hi("@lsp.type.number",      { fg = num })
hi("@lsp.type.function",    { fg = fn,        bold = true })
hi("@lsp.type.method",      { fg = fn })
hi("@lsp.type.type",        { fg = type_,     bold = true })
hi("@lsp.type.typeParameter",{ fg = type_ })
hi("@lsp.type.comment",     { fg = p.comment, italic = true })
hi("@lsp.type.variable",    { fg = fg })
hi("@lsp.type.parameter",   { fg = fg })
hi("@lsp.type.property",    { fg = fg })
hi("@lsp.type.enumMember",  { fg = num })
hi("@lsp.type.namespace",   { fg = type_ })
hi("@lsp.type.macro",       { fg = builtin })
hi("@lsp.type.builtinType", { fg = type_,     bold = true })

-- ── Diagnostics ───────────────────────────────────────────────────────────────

hi("DiagnosticError",       { fg = str })
hi("DiagnosticWarn",        { fg = p.orange })
hi("DiagnosticInfo",        { fg = builtin })
hi("DiagnosticHint",        { fg = num })
hi("DiagnosticUnderlineError",{ undercurl = true, sp = str })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = p.orange })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = builtin })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = num })

-- ── Git / diff ────────────────────────────────────────────────────────────────

hi("GitSignsAdd",    { fg = p.str_dark })
hi("GitSignsChange", { fg = num })
hi("GitSignsDelete", { fg = str })
