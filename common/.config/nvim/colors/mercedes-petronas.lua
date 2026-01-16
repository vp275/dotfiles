-- Mercedes Petronas Neovim Theme
-- Inspired by Mercedes-AMG Petronas F1 team colors
-- Design principle: minimal highlighting, use lightness for hierarchy

vim.cmd("hi clear")
if vim.fn.exists("syntax_on") then
  vim.cmd("syntax reset")
end
vim.g.colors_name = "mercedes-petronas"

-- Color Palette
local c = {
  -- Backgrounds (darkest to lightest)
  bg0 = "#0A0A0A",       -- Pure black - main background
  bg1 = "#121212",       -- Slightly lighter - cursorline
  bg2 = "#1A1A1A",       -- Dark grey - selection, visual
  bg3 = "#252525",       -- UI elements

  -- Foregrounds
  fg0 = "#f2f4f8",       -- Primary text
  fg1 = "#d0d0d0",       -- Secondary text
  fg2 = "#a0a0a0",       -- Muted text (keywords)
  fg3 = "#6e6e6e",       -- Comments, line numbers

  -- Mercedes accents
  teal = "#00D2BE",      -- Primary accent - strings, values
  teal_light = "#7AEEE0", -- Functions, definitions
  teal_dark = "#00A896", -- Secondary accent
  silver = "#D8D8D8",    -- Tertiary

  -- Semantic colors
  scarlet = "#CC2936",   -- Errors
  green = "#25be6a",     -- Success, added
  blue = "#78A9FF",      -- Info, hints (kept for variety)
  yellow = "#FFCC00",    -- Warnings

  none = "NONE",
}

-- Helper function
local function hi(group, opts)
  vim.api.nvim_set_hl(0, group, opts)
end

-- Editor UI
hi("Normal", { fg = c.fg0, bg = c.bg0 })
hi("NormalFloat", { fg = c.fg0, bg = c.bg0 })
hi("NormalNC", { fg = c.fg0, bg = c.bg0 })
hi("Cursor", { fg = c.bg0, bg = c.teal })
hi("CursorLine", { bg = c.bg1 })
hi("CursorColumn", { bg = c.bg1 })
hi("ColorColumn", { bg = c.bg1 })
hi("LineNr", { fg = c.fg3, bg = c.bg0 })
hi("CursorLineNr", { fg = c.teal, bg = c.bg1, bold = true })
hi("SignColumn", { fg = c.fg3, bg = c.bg0 })
hi("FoldColumn", { fg = c.fg3, bg = c.bg0 })
hi("Folded", { fg = c.fg2, bg = c.bg2 })
hi("VertSplit", { fg = c.bg3, bg = c.bg0 })
hi("WinSeparator", { fg = c.bg3, bg = c.bg0 })
hi("StatusLine", { fg = c.fg0, bg = c.bg2 })
hi("StatusLineNC", { fg = c.fg3, bg = c.bg1 })
hi("TabLine", { fg = c.fg2, bg = c.bg1 })
hi("TabLineFill", { bg = c.bg0 })
hi("TabLineSel", { fg = c.fg0, bg = c.bg0, bold = true })
hi("EndOfBuffer", { fg = c.bg0, bg = c.bg0 })
hi("NonText", { fg = c.bg3 })
hi("SpecialKey", { fg = c.bg3 })
hi("Whitespace", { fg = c.bg3 })

-- Search & Selection
hi("Visual", { bg = c.bg2 })
hi("VisualNOS", { bg = c.bg2 })
hi("Search", { fg = c.bg0, bg = c.teal })
hi("IncSearch", { fg = c.bg0, bg = c.teal_light })
hi("CurSearch", { fg = c.bg0, bg = c.teal_light })
hi("Substitute", { fg = c.bg0, bg = c.scarlet })

-- Popup menu
hi("Pmenu", { fg = c.fg0, bg = c.bg1 })
hi("PmenuSel", { fg = c.bg0, bg = c.teal })
hi("PmenuSbar", { bg = c.bg2 })
hi("PmenuThumb", { bg = c.teal_dark })

-- Messages
hi("ErrorMsg", { fg = c.scarlet })
hi("WarningMsg", { fg = c.yellow })
hi("ModeMsg", { fg = c.fg0, bold = true })
hi("MoreMsg", { fg = c.teal })
hi("Question", { fg = c.teal })
hi("Title", { fg = c.teal_light, bold = true })
hi("Directory", { fg = c.teal })

-- Diff
hi("DiffAdd", { fg = c.green, bg = "#0d2818" })
hi("DiffChange", { fg = c.blue, bg = "#0d1a2d" })
hi("DiffDelete", { fg = c.scarlet, bg = "#2d0d12" })
hi("DiffText", { fg = c.fg0, bg = "#1a3050" })

-- Spelling
hi("SpellBad", { undercurl = true, sp = c.scarlet })
hi("SpellCap", { undercurl = true, sp = c.yellow })
hi("SpellLocal", { undercurl = true, sp = c.blue })
hi("SpellRare", { undercurl = true, sp = c.teal })

-- Diagnostics
hi("DiagnosticError", { fg = c.scarlet })
hi("DiagnosticWarn", { fg = c.yellow })
hi("DiagnosticInfo", { fg = c.blue })
hi("DiagnosticHint", { fg = c.teal })
hi("DiagnosticOk", { fg = c.green })
hi("DiagnosticUnderlineError", { undercurl = true, sp = c.scarlet })
hi("DiagnosticUnderlineWarn", { undercurl = true, sp = c.yellow })
hi("DiagnosticUnderlineInfo", { undercurl = true, sp = c.blue })
hi("DiagnosticUnderlineHint", { undercurl = true, sp = c.teal })

-- SYNTAX HIGHLIGHTING (Minimalist approach)
-- Following Tonsky's principles: highlight strings, constants, functions
-- De-emphasize keywords (they're structural, not what you search for)

-- Comments - visible but muted
hi("Comment", { fg = c.fg3, italic = true })

-- Constants & Strings - IMPORTANT, use primary teal
hi("Constant", { fg = c.teal })
hi("String", { fg = c.teal })
hi("Character", { fg = c.teal })
hi("Number", { fg = c.teal })
hi("Boolean", { fg = c.teal })
hi("Float", { fg = c.teal })

-- Identifiers & Functions - secondary importance, light teal
hi("Identifier", { fg = c.fg0 })
hi("Function", { fg = c.teal_light })

-- Keywords - DE-EMPHASIZED (you don't search for 'if' or 'return')
hi("Statement", { fg = c.fg2 })
hi("Conditional", { fg = c.fg2 })
hi("Repeat", { fg = c.fg2 })
hi("Label", { fg = c.fg2 })
hi("Operator", { fg = c.fg1 })
hi("Keyword", { fg = c.fg2 })
hi("Exception", { fg = c.fg2 })

-- Preprocessor - muted
hi("PreProc", { fg = c.fg2 })
hi("Include", { fg = c.fg2 })
hi("Define", { fg = c.fg2 })
hi("Macro", { fg = c.teal_dark })
hi("PreCondit", { fg = c.fg2 })

-- Types - use silver/light for structure
hi("Type", { fg = c.silver })
hi("StorageClass", { fg = c.fg2 })
hi("Structure", { fg = c.silver })
hi("Typedef", { fg = c.silver })

-- Special
hi("Special", { fg = c.teal_dark })
hi("SpecialChar", { fg = c.teal })
hi("Tag", { fg = c.teal_light })
hi("Delimiter", { fg = c.fg1 })
hi("SpecialComment", { fg = c.teal_dark, italic = true })
hi("Debug", { fg = c.scarlet })

-- Other
hi("Underlined", { fg = c.teal, underline = true })
hi("Ignore", { fg = c.fg3 })
hi("Error", { fg = c.scarlet, bold = true })
hi("Todo", { fg = c.bg0, bg = c.teal, bold = true })

-- Treesitter highlights (more specific)
hi("@variable", { fg = c.fg0 })
hi("@variable.builtin", { fg = c.teal_dark })
hi("@variable.parameter", { fg = c.fg0 })
hi("@variable.member", { fg = c.fg1 })

hi("@constant", { fg = c.teal })
hi("@constant.builtin", { fg = c.teal })
hi("@constant.macro", { fg = c.teal })

hi("@module", { fg = c.fg1 })
hi("@label", { fg = c.fg2 })

hi("@string", { fg = c.teal })
hi("@string.documentation", { fg = c.fg3 })
hi("@string.regexp", { fg = c.teal_dark })
hi("@string.escape", { fg = c.teal_light })
hi("@string.special", { fg = c.teal_dark })

hi("@character", { fg = c.teal })
hi("@character.special", { fg = c.teal_light })

hi("@boolean", { fg = c.teal })
hi("@number", { fg = c.teal })
hi("@number.float", { fg = c.teal })

hi("@type", { fg = c.silver })
hi("@type.builtin", { fg = c.silver })
hi("@type.definition", { fg = c.silver })

hi("@attribute", { fg = c.teal_dark })
hi("@property", { fg = c.fg1 })

hi("@function", { fg = c.teal_light })
hi("@function.builtin", { fg = c.teal_light })
hi("@function.call", { fg = c.teal_light })
hi("@function.macro", { fg = c.teal_dark })
hi("@function.method", { fg = c.teal_light })
hi("@function.method.call", { fg = c.teal_light })

hi("@constructor", { fg = c.teal_light })

hi("@operator", { fg = c.fg1 })

hi("@keyword", { fg = c.fg2 })
hi("@keyword.coroutine", { fg = c.fg2 })
hi("@keyword.function", { fg = c.fg2 })
hi("@keyword.operator", { fg = c.fg2 })
hi("@keyword.import", { fg = c.fg2 })
hi("@keyword.storage", { fg = c.fg2 })
hi("@keyword.repeat", { fg = c.fg2 })
hi("@keyword.return", { fg = c.fg2 })
hi("@keyword.debug", { fg = c.scarlet })
hi("@keyword.exception", { fg = c.fg2 })
hi("@keyword.conditional", { fg = c.fg2 })
hi("@keyword.directive", { fg = c.fg2 })

hi("@punctuation.delimiter", { fg = c.fg2 })
hi("@punctuation.bracket", { fg = c.fg2 })
hi("@punctuation.special", { fg = c.teal_dark })

hi("@comment", { fg = c.fg3, italic = true })
hi("@comment.documentation", { fg = c.fg3, italic = true })
hi("@comment.error", { fg = c.scarlet, bg = "#2d0d12" })
hi("@comment.warning", { fg = c.yellow, bg = "#2d2a0d" })
hi("@comment.todo", { fg = c.bg0, bg = c.teal, bold = true })
hi("@comment.note", { fg = c.bg0, bg = c.blue })

hi("@markup.strong", { bold = true })
hi("@markup.italic", { italic = true })
hi("@markup.strikethrough", { strikethrough = true })
hi("@markup.underline", { underline = true })
hi("@markup.heading", { fg = c.teal_light, bold = true })
hi("@markup.quote", { fg = c.fg2, italic = true })
hi("@markup.math", { fg = c.teal })
hi("@markup.environment", { fg = c.teal_dark })
hi("@markup.link", { fg = c.teal, underline = true })
hi("@markup.link.label", { fg = c.teal })
hi("@markup.link.url", { fg = c.teal_dark, underline = true })
hi("@markup.raw", { fg = c.teal_dark })
hi("@markup.raw.block", { fg = c.fg1 })
hi("@markup.list", { fg = c.teal })

hi("@diff.plus", { fg = c.green })
hi("@diff.minus", { fg = c.scarlet })
hi("@diff.delta", { fg = c.blue })

hi("@tag", { fg = c.teal_light })
hi("@tag.attribute", { fg = c.fg1 })
hi("@tag.delimiter", { fg = c.fg2 })

-- LSP semantic tokens
hi("@lsp.type.class", { fg = c.silver })
hi("@lsp.type.decorator", { fg = c.teal_dark })
hi("@lsp.type.enum", { fg = c.silver })
hi("@lsp.type.enumMember", { fg = c.teal })
hi("@lsp.type.function", { fg = c.teal_light })
hi("@lsp.type.interface", { fg = c.silver })
hi("@lsp.type.macro", { fg = c.teal_dark })
hi("@lsp.type.method", { fg = c.teal_light })
hi("@lsp.type.namespace", { fg = c.fg1 })
hi("@lsp.type.parameter", { fg = c.fg0 })
hi("@lsp.type.property", { fg = c.fg1 })
hi("@lsp.type.struct", { fg = c.silver })
hi("@lsp.type.type", { fg = c.silver })
hi("@lsp.type.typeParameter", { fg = c.silver })
hi("@lsp.type.variable", { fg = c.fg0 })

-- Git signs
hi("GitSignsAdd", { fg = c.green, bg = c.bg0 })
hi("GitSignsChange", { fg = c.blue, bg = c.bg0 })
hi("GitSignsDelete", { fg = c.scarlet, bg = c.bg0 })

-- Telescope
hi("TelescopeBorder", { fg = c.teal_dark, bg = c.bg0 })
hi("TelescopePromptBorder", { fg = c.teal, bg = c.bg0 })
hi("TelescopeResultsBorder", { fg = c.bg3, bg = c.bg0 })
hi("TelescopePreviewBorder", { fg = c.bg3, bg = c.bg0 })
hi("TelescopeSelection", { fg = c.fg0, bg = c.bg2 })
hi("TelescopeSelectionCaret", { fg = c.teal })
hi("TelescopeMatching", { fg = c.teal, bold = true })
hi("TelescopePromptPrefix", { fg = c.teal })

-- Neo-tree
hi("NeoTreeNormal", { fg = c.fg0, bg = c.bg0 })
hi("NeoTreeNormalNC", { fg = c.fg0, bg = c.bg0 })
hi("NeoTreeDirectoryName", { fg = c.teal })
hi("NeoTreeDirectoryIcon", { fg = c.teal })
hi("NeoTreeRootName", { fg = c.teal_light, bold = true })
hi("NeoTreeFileName", { fg = c.fg0 })
hi("NeoTreeFileIcon", { fg = c.fg1 })
hi("NeoTreeGitAdded", { fg = c.green })
hi("NeoTreeGitDeleted", { fg = c.scarlet })
hi("NeoTreeGitModified", { fg = c.blue })

-- Which-key
hi("WhichKey", { fg = c.teal })
hi("WhichKeyGroup", { fg = c.teal_light })
hi("WhichKeyDesc", { fg = c.fg0 })
hi("WhichKeySeparator", { fg = c.fg3 })
hi("WhichKeyFloat", { bg = c.bg0 })

-- Indent guides
hi("IndentBlanklineChar", { fg = c.bg3 })
hi("IndentBlanklineContextChar", { fg = c.teal_dark })
hi("IblIndent", { fg = c.bg3 })
hi("IblScope", { fg = c.teal_dark })

-- Notify
hi("NotifyERRORBorder", { fg = c.scarlet })
hi("NotifyWARNBorder", { fg = c.yellow })
hi("NotifyINFOBorder", { fg = c.teal })
hi("NotifyDEBUGBorder", { fg = c.fg3 })
hi("NotifyTRACEBorder", { fg = c.teal_dark })
hi("NotifyERRORIcon", { fg = c.scarlet })
hi("NotifyWARNIcon", { fg = c.yellow })
hi("NotifyINFOIcon", { fg = c.teal })
hi("NotifyDEBUGIcon", { fg = c.fg3 })
hi("NotifyTRACEIcon", { fg = c.teal_dark })
hi("NotifyERRORTitle", { fg = c.scarlet })
hi("NotifyWARNTitle", { fg = c.yellow })
hi("NotifyINFOTitle", { fg = c.teal })
hi("NotifyDEBUGTitle", { fg = c.fg3 })
hi("NotifyTRACETitle", { fg = c.teal_dark })

-- Lualine will pick up highlights automatically
