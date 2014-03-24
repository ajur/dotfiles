" Vim color file
" Maintainer: Adam Jurczyk <ajur.pl@gmail.com>
" Last Change: 26 mar 2009 13:15:59
"

set t_Co=255

set background=dark
hi clear
if exists("syntax_on")
  syntax reset
endif

let g:colors_name = "ajur"

" normal
hi Normal ctermfg=252 guifg=#d0d0d0 guibg=#262626

" Colors for syntax highlighting
hi Comment term=italic ctermfg=44 guifg=#00d7d7
hi Constant term=underline ctermfg=75 guifg=#5fafff
hi Special term=bold ctermfg=207 guifg=#ff5fff gui=bold
hi Identifier term=bold ctermfg=204 cterm=NONE guifg=#ff5f87
hi Statement term=bold ctermfg=141 guifg=#af87ff
hi PreProc term=underline ctermfg=40 guifg=#00d700
hi Type term=underline ctermfg=167 guifg=#d75f5f
hi Underlined term=underline cterm=underline gui=underline
hi Ignore ctermfg=66 guifg=#5f8787
hi Error term=reverse ctermfg=255 ctermbg=160 guifg=#eeeeee guibg=#d70000
hi Todo term=standout ctermfg=32 ctermbg=24 guifg=#0087d7 guibg=#005f87

" other
hi SpecialKey term=bold ctermfg=63 guifg=#5f5fff
hi NonText term=italic ctermfg=244 guifg=#808080
hi Directory term=bold ctermfg=147 guifg=#afafff
hi link ErrorMsg Error
hi link IncSearch Search
hi Search term=reverse cterm=reverse gui=reverse
hi MoreMsg term=bold ctermfg=21 gui=bold guifg=#0000ff
hi ModeMsg term=bold cterm=bold gui=bold
hi LineNr term=italic ctermfg=36 guifg=#00af87
hi Question term=standout ctermfg=84 gui=bold guifg=#5fff84
hi StatusLine term=bold,reverse ctermfg=247 ctermbg=235 guifg=#9e9e9e guibg=#262626
hi StatusLineNC term=reverse ctermfg=235 ctermbg=247 guifg=#262626 guibg=#9e9e9e
hi link VertSplit StatusLineNC
hi Title term=underline ctermfg=117 gui=underline guifg=#87d7ff
hi Visual term=reverse cterm=reverse gui=reverse
hi VisualNOS term=underline,reverse cterm=underline,reverse gui=underline,reverse
hi WarningMsg term=standout ctermfg=202 gui=bold guifg=#ff5f00
hi link WildMenu Search
hi link Folded NonText
hi link FoldColumn Folded
hi DiffAdd term=bold ctermbg=214 guibg=#ffaf00
hi DiffChange term=bold ctermbg=204 guibg=#ff5f87
hi DiffDelete term=bold ctermbg=135 guibg=#af5fff
hi DiffText term=reverse ctermbg=202 guibg=#ff5f00
hi Cursor term=reverse cterm=reverse gui=reverse
"hi lCursor guifg=bg guibg=fg

" spell
hi SpellBad term=standout ctermfg=228 ctermbg=196 guifg=#ffff87 guibg=#ff0000
hi SpellCap term=standout ctermfg=228 ctermbg=76 guifg=#ffff87 guibg=#5fd700
hi SpellRare term=italic ctermfg=228 ctermbg=162 guifg=#ffff87 guibg=#d70087
hi link SPellLocal SpellRare

" Vim >= 7.0 specific colors
if version >= 700
  hi CursorLine guibg=#303030
  hi CursorColumn guibg=#303030
  hi MatchParen term=bold cterm=bold  gui=bold
  hi Pmenu ctermfg=42 ctermbg=30 guifg=#00d787 guibg=#008787
  hi PmenuSel ctermfg=42 ctermbg=32 guifg=#00d787 guibg=#0087d7
endif

hi link pythonBuildin Constant
hi link pythonException Type

