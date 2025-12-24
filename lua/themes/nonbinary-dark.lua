-- lua/custom/themes/nonbinary-dark.lua
vim.g.colors_name = 'nonbinary-dark'
local hl = vim.api.nvim_set_hl

-- === Palette ===
local c = {
  white = '#ebebeb',
  black = '#2f1f31',
  darker_black = '#15151a',
  black2 = '#352433',
  one_bg = '#2f1f31',
  one_bg2 = '#352433',
  one_bg3 = '#3a2738',
  grey = '#6e6e76',
  grey_fg = '#15f371',
  grey_fg2 = '#7aaeb0',
  light_grey = '#9fd6d8',
  line = '#8a4bbf',
  selection = '#2f4f73',
  selection_strong = '#355b87',
  comment = '#15f371',
  nvim_tree_bg = '#19161b',
  red = '#ff6b6b',
  baby_pink = '#c97fcf',
  pink = '#b25db0',
  line_bg = '#1b1620',
  green = '#33caa0',
  vibrant_green = '#4ea1e6',
  blue = '#4ea1e6',
  nord_blue = '#3fe2d4',
  yellow = '#f0bf00',
  sun = '#e07a4a',
  purple = '#8a4bbf',
  dark_purple = '#6b3b9a',
  teal = '#3fe2d4',
  orange = '#e07a4a',
  cyan = '#3fe2d4',
  statusline_bg = '#8a4bbf',
  lightbg = '#352433',
  pmenu_bg = '#19161b',
  folder_bg = '#9fd6d8',
}

-- Semantic aliases
local bg = c.black
local fg = c.light_grey
local cursorFg = c.darker_black
local cursorBg = c.yellow
local selection = c.selection
local selectionStrong = c.selection_strong
local statusBg = c.statusline_bg
local statusFg = c.white
local comment = c.comment
local string = c.sun
local number = c.baby_pink
local constant = c.vibrant_green
local typ = c.green
local keyword = c.pink
local operator = c.green
local func = c.yellow
local var = c.light_grey
local namespace = c.nord_blue
local errorFg = c.red
local warnFg = c.sun
local infoFg = c.blue
local hintFg = c.nord_blue
local gutterBg = c.darker_black
local linenr = c.grey
local linenrSel = c.white
local indentGuide = c.line_bg

-- === Core UI groups ===
hl(0, 'Normal', { bg = bg, fg = fg })
hl(0, 'Cursor', { fg = cursorFg, bg = cursorBg })
hl(0, 'Visual', { bg = selection, fg = '#ffffff' })
hl(0, 'VisualNOS', { bg = selection })
hl(0, 'CursorLine', { bg = c.black2 })
hl(0, 'CursorLineNr', { fg = linenrSel })
hl(0, 'LineNr', { fg = linenr })
hl(0, 'StatusLine', { bg = statusBg, fg = statusFg })
hl(0, 'StatusLineNC', { bg = c.darker_black, fg = c.pink })
hl(0, 'Pmenu', { bg = c.pmenu_bg, fg = fg })
hl(0, 'PmenuSel', { bg = selectionStrong, fg = '#ffffff' })
hl(0, 'PmenuSbar', { bg = c.nvim_tree_bg })
hl(0, 'PmenuThumb', { bg = selectionStrong })
hl(0, 'Title', { fg = statusFg, bold = true })
hl(0, 'TabLine', { bg = c.line_bg, fg = c.grey_fg2 })
hl(0, 'TabLineSel', { bg = statusBg, fg = statusFg })
hl(0, 'SignColumn', { bg = bg })
hl(0, 'ColorColumn', { bg = c.one_bg3 })
hl(0, 'CursorColumn', { bg = c.one_bg3 })
hl(0, 'Conceal', { fg = c.grey_fg2 })
hl(0, 'MatchParen', { fg = c.yellow, bold = true })

-- Indent guide
hl(0, 'IndentBlanklineChar', { fg = indentGuide })

-- === Standard vim groups ===
hl(0, 'Comment', { fg = comment, italic = true })
hl(0, 'String', { fg = string })
hl(0, 'Number', { fg = number })
hl(0, 'Constant', { fg = constant })
hl(0, 'Boolean', { fg = constant })
hl(0, 'Identifier', { fg = var })
hl(0, 'Function', { fg = func })
hl(0, 'Keyword', { fg = keyword })
hl(0, 'Operator', { fg = operator })
hl(0, 'Type', { fg = typ })
hl(0, 'Structure', { fg = namespace })
hl(0, 'PreProc', { fg = keyword })
hl(0, 'Special', { fg = keyword })
hl(0, 'Error', { fg = errorFg, bg = gutterBg })
hl(0, 'WarningMsg', { fg = warnFg, bg = gutterBg })
hl(0, 'Info', { fg = infoFg, bg = gutterBg })
hl(0, 'Hint', { fg = hintFg, bg = gutterBg })

-- === Extra Treesitter groups: variables & punctuation (and close variants) ===
hl(0, '@variable', { fg = c.light_grey }) -- general variables
hl(0, '@variable.builtin', { fg = c.vibrant_green }) -- builtin vars/constants
hl(0, '@variable.other', { fg = c.light_grey }) -- other variable forms
hl(0, '@variable.parameter', { fg = c.light_grey }) -- function parameters

-- punctuation groups (brackets, delimiters, special punctuation)
hl(0, '@punctuation', { fg = c.line }) -- generic punctuation
hl(0, '@punctuation.bracket', { fg = c.line }) -- brackets: (), [], {}
hl(0, '@punctuation.delimiter', { fg = c.line }) -- delimiters: commas/colons/etc
hl(0, '@punctuation.special', { fg = c.line }) -- special punctuations (e.g. #, @)
hl(0, '@punctuation.bracket.lparen', { fg = c.line }) -- optional fine grained
hl(0, '@punctuation.bracket.rparen', { fg = c.line })

-- some niceties for plain text / strong text
hl(0, '@text', { fg = fg })
hl(0, '@text.strong', { fg = fg, bold = true })
hl(0, '@text.reference', { fg = c.blue }) -- e.g. refs/links

-- === Treesitter groups (mirror your Base46 mapping exactly) ===
hl(0, '@comment', { fg = c.comment, italic = true }) -- base03
hl(0, '@character', { fg = c.sun })
hl(0, '@string', { fg = c.sun }) -- base0B
hl(0, '@string.regex', { fg = c.sun })
hl(0, '@number', { fg = c.baby_pink }) -- base09
hl(0, '@boolean', { fg = c.vibrant_green })
hl(0, '@constant', { fg = c.vibrant_green })
hl(0, '@constant.builtin', { fg = c.vibrant_green })
hl(0, '@identifier', { fg = c.light_grey }) -- base05
hl(0, '@function', { fg = c.yellow }) -- base0D
hl(0, '@function.call', { fg = c.yellow })
hl(0, '@method', { fg = c.yellow })
hl(0, '@constructor', { fg = c.cyan })
hl(0, '@keyword', { fg = c.pink }) -- base0E
hl(0, '@conditional', { fg = c.pink })
hl(0, '@keyword.repeat', { fg = c.pink })
hl(0, '@keyword.exception', { fg = c.pink })
hl(0, '@repeat', { fg = c.pink })
hl(0, '@type', { fg = c.green }) -- base0A
hl(0, '@type.builtin', { fg = c.blue }) -- distinct from @type
hl(0, '@namespace', { fg = c.nord_blue }) -- base0C / teal-like
hl(0, '@module', { fg = c.green })
hl(0, '@parameter', { fg = c.light_grey })
hl(0, '@property', { fg = c.light_grey })
hl(0, '@field', { fg = c.light_grey })
hl(0, '@tag', { fg = c.pink })
hl(0, '@operator', { fg = c.green })

-- Extra / C++ style tokens
hl(0, '@keyword.storage', { fg = c.pink })
hl(0, '@keyword.type.cpp', { fg = c.blue })
hl(0, '@macro', { fg = c.vibrant_green })
hl(0, '@symbol', { fg = c.vibrant_green })
hl(0, '@enum', { fg = c.vibrant_green })
hl(0, '@enum.member', { fg = c.vibrant_green })
hl(0, '@enum.variant', { fg = c.vibrant_green })

-- Defensive / grammar variants
hl(0, 'Include', { fg = c.pink })
hl(0, 'token', { fg = c.vibrant_green })

-- === Diagnostics: undercurl colors & sign highlights ===
hl(0, 'DiagnosticUnderlineError', { undercurl = true, sp = c.red })
hl(0, 'DiagnosticUnderlineWarn', { undercurl = true, sp = c.sun })
hl(0, 'DiagnosticUnderlineInfo', { undercurl = true, sp = c.blue })
hl(0, 'DiagnosticUnderlineHint', { undercurl = true, sp = c.nord_blue })

hl(0, 'DiagnosticSignError', { fg = c.red })
hl(0, 'DiagnosticSignWarn', { fg = c.sun })
hl(0, 'DiagnosticSignInfo', { fg = c.blue })
hl(0, 'DiagnosticSignHint', { fg = c.nord_blue })

-- === Git signs (gitsigns / signcolumn) ===
hl(0, 'GitSignsAdd', { fg = c.vibrant_green })
hl(0, 'GitSignsChange', { fg = c.green })
hl(0, 'GitSignsDelete', { fg = c.red })
hl(0, 'GitSignsAddNr', { fg = c.vibrant_green })
hl(0, 'GitSignsChangeNr', { fg = c.green })
hl(0, 'GitSignsDeleteNr', { fg = c.red })

-- Diff groups
hl(0, 'DiffAdd', { fg = c.vibrant_green })
hl(0, 'DiffChange', { fg = c.green })
hl(0, 'DiffDelete', { fg = c.red })

-- Floats / diagnostic floats
hl(0, 'DiagnosticFloating', { bg = c.one_bg3, fg = fg })
hl(0, 'DiagnosticFloatBorder', { fg = c.pink, bg = c.one_bg3 })

-- lualine / separators
hl(0, 'WinSeparator', { fg = '#d0a3ff', bg = 'NONE' })
hl(0, 'VertSplit', { fg = '#d0a3ff', bg = 'NONE' })

-- Fallback links (direct vim.cmd calls as you requested)
vim.cmd 'hi link @variable Identifier'
vim.cmd 'hi link @function Function'
vim.cmd 'hi link @keyword Keyword'
vim.cmd 'hi link @string String'
vim.cmd 'hi link @number Number'
vim.cmd 'hi link @comment Comment'
vim.cmd 'hi link @type Type'

-- Token fallback (set Token fg explicitly)
vim.cmd('hi Token guifg=' .. c.vibrant_green)

-- Export a palette table for plugin use / user reference
vim.g.nonbinary_dark_palette = {
  white = c.white,
  black = c.black,
  darker_black = c.darker_black,
  black2 = c.black2,
  one_bg = c.one_bg,
  one_bg2 = c.one_bg2,
  one_bg3 = c.one_bg3,
  grey = c.grey,
  grey_fg = c.grey_fg,
  grey_fg2 = c.grey_fg2,
  light_grey = c.light_grey,
  line = c.line,
  selection = c.selection,
  selection_strong = c.selection_strong,
  comment = c.comment,
  nvim_tree_bg = c.nvim_tree_bg,
  red = c.red,
  baby_pink = c.baby_pink,
  pink = c.pink,
  green = c.green,
  vibrant_green = c.vibrant_green,
  blue = c.blue,
  nord_blue = c.nord_blue,
  yellow = c.yellow,
  sun = c.sun,
  purple = c.purple,
  teal = c.teal,
  orange = c.orange,
  cyan = c.cyan,
  statusline_bg = c.statusline_bg,
  pmenu_bg = c.pmenu_bg,
  folder_bg = c.folder_bg,
}

-- Diagnostic config defaults (applied at colorscheme load)
vim.diagnostic.config {
  signs = true,
  underline = true,
  virtual_text = {
    spacing = 2,
    prefix = '●',
  },
  float = { border = 'rounded' },
  update_in_insert = false,
}
