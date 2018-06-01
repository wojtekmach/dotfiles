" based on https://github.com/wolverian/minimal
set background=light
hi clear
if exists("syntax_on")
  syntax reset
endif
let g:colors_name = "wojtek"
hi Normal		guifg=#424242	ctermfg=black guibg=#F4F3F1
hi NonText		guifg=#424242	ctermfg=black
hi comment		guifg=gray		ctermfg=brown
hi constant		guifg=#000000		ctermfg=brown cterm=none
hi string guifg=darkgray ctermfg=brown
hi identifier	guifg=#424242		ctermfg=black
hi statement	guifg=#424242		ctermfg=black	gui=bold cterm=bold
hi define gui=bold cterm=bold
hi preproc		guifg=#424242		ctermfg=black
hi type			guifg=#424242	ctermfg=black	gui=bold
hi special		guifg=#424242	ctermfg=black	ctermfg=black
hi Underlined	guifg=#424242		ctermfg=black	gui=underline	cterm=underline
hi label		guifg=#424242	ctermfg=black
hi operator		guifg=#424242	ctermfg=black
hi delimiter guifg=darkgray ctermfg=brown gui=NONE

hi ErrorMsg		guifg=#424242	guifg=#424242	ctermfg=black
hi WarningMsg	guifg=#424242		ctermfg=black	gui=bold cterm=bold
hi ModeMsg		guifg=#424242	gui=NONE	ctermfg=black
hi MoreMsg		guifg=#424242	gui=NONE	ctermfg=black
hi Error		guifg=#424242		guifg=#424242	gui=underline	ctermfg=black

hi Todo			guifg=#424242		guifg=#424242	ctermfg=black	ctermfg=black
hi Cursor		guifg=#424242		guifg=#424242		ctermfg=black	ctermfg=black
hi Search		guifg=#424242		guifg=#424242	ctermfg=black	ctermfg=black
hi IncSearch	guifg=#424242		guifg=#424242	ctermfg=black	ctermfg=black
hi LineNr		guifg=#424242		ctermfg=lightgrey
hi title		guifg=#424242	gui=bold	cterm=bold

hi StatusLine    cterm=none gui=none    guifg=white ctermfg=white guibg=black ctermbg=black
hi StatusLineNC  cterm=none gui=none    guifg=fg    ctermfg=fg    guibg=#cccbca ctermbg=white
hi! VertSplit     gui=none   guifg=#424242 guifg=#424242 cterm=none

hi Visual		term=reverse		ctermfg=black	ctermfg=black	guifg=#424242		guifg=#424242

hi DiffChange	guifg=#424242		guifg=#424242	ctermfg=brown
hi DiffText		guifg=#424242		guifg=#424242		ctermfg=lightgrey
hi DiffAdd		guifg=#424242		guifg=#424242		ctermfg=green
hi DiffDelete   guifg=#424242			guifg=#424242	ctermfg=red

hi Folded		guifg=#424242		guifg=#424242		ctermfg=black		ctermfg=black
hi FoldColumn	guifg=#424242		guifg=#424242	ctermfg=black		ctermfg=black
hi cIf0			guifg=#424242			ctermfg=black
