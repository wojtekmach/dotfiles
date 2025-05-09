set swapfile

call plug#begin('~/.vim/plugged')
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-endwise'
Plug 'tpope/vim-projectionist'
Plug 'tpope/vim-dispatch'
Plug 'bogado/file-line'
Plug 'preservim/nerdtree'
" Plug 'wojtekmach/vim-test', {'branch': 'wm-last'}
Plug 'vim-test/vim-test'
Plug 'skywind3000/asyncrun.vim'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'mattn/webapi-vim'
Plug 'mattn/vim-gist'
Plug 'tpope/vim-dadbod'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'ziglang/zig.vim'
" elixir
Plug 'elixir-editors/vim-elixir'
Plug 'lfe/vim-lfe'
Plug 'gleam-lang/gleam.vim'
Plug 'rking/ag.vim'
" Plug 'editorconfig/editorconfig-vim'
call plug#end()

" general
set ts=4 sts=2 sw=2 expandtab
colorscheme wojtek
let mapleader=","
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=/Users/wojtek/tmp
set hidden
set listchars=tab:>-,trail:~,extends:>,precedes:<
set list
set fillchars=eob:\ 
nnoremap <leader>w :q<CR>
" cmd+s is mapped to F6 (0x117) in iterm
nnoremap <F6> :w<CR>
inoremap <F6> <Esc>:w<CR>a
"" allow unsaved background buffers and remember marks/undo for them
nnoremap <space> <enter>

" auto-reload vimrc
augroup myvimrc
  au!
  au BufWritePost .vimrc,_vimrc,vimrc,.gvimrc,_gvimrc,gvimrc so $MYVIMRC | if has('gui_running') | so $MYGVIMRC | endif
augroup END

" line length
set textwidth=98


" Keep wrap for .md files but don't insert newlines automatically
autocmd FileType markdown setlocal wrap
autocmd FileType markdown setlocal textwidth=0 colorcolumn=""

au BufNewFile,BufRead .erlang set filetype=erlang

" vim-projectionist
let g:projectionist_heuristics = {
    \   ".elixir_core": {
    \     "lib/elixir/lib/*.ex": { "alternate": "lib/elixir/test/elixir/{}_test.exs", "type": "source" },
    \     "lib/elixir/test/elixir/*_test.exs": { "alternate": "lib/elixir/lib/{}.ex", "type": "source" }
    \   },
    \   "rebar.config": {
    \     "src/*.erl": { "alternate": "test/{}_tests.erl", "type": "source" },
    \     "test/*_tests.erl": { "alternate": "src/{}.erl", "type": "source" }
    \   },
    \   "mix.exs": {
    \     "lib/*.ex":        { "alternate": "test/{}_test.exs", "type": "source" },
    \     "test/*_test.exs": { "alternate": "lib/{}.ex", "type": "test" },
    \   },
    \ }
nnoremap <leader>, :A<CR>

" fzf
let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --glob "!.git"'
silent! nmap <leader>f :Rg<CR>
silent! nmap <leader>t :Files<CR>

" vim-test
let test#strategy = "vimterminal"
let test#vim#term_position = "vert botright"
" augroup test
"   autocmd!
"   autocmd BufWrite * if test#exists() |
"     \   TestFile |
"     \ endif
" augroup END
nmap <silent> t :wa\|:TestLast<CR>
nmap <silent> <c-t> :wa\|:TestNearest<CR>
nmap <silent> T :wa\|:TestFile<CR>
nmap <silent> <leader>a :wa\|:TestSuite<CR>
let g:test#elixir#exunit#file_pattern = '\.exs$'

" vim-gist
let g:gist_post_private = 1

" mix format
autocmd! BufWritePost   *.ex,*.exs :Dispatch! ~/bin/m format <afile>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Random
"
" Mostly stolen from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

" RENAME CURRENT FILE
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction
map <leader>n :call RenameFile()<cr>

" https://vi.stackexchange.com/a/679
augroup Mkdir
  autocmd!
  autocmd BufWritePre *
    \ if !isdirectory(expand("<afile>:p:h")) |
        \ call mkdir(expand("<afile>:p:h"), "p") |
    \ endif
augroup END

noremap c[ :w\|:cprev<CR>
noremap c] :w\|:cnext<CR>



let s:hidden_all = 0
function! ToggleHiddenAll()
    if s:hidden_all  == 0
        let s:hidden_all = 1
        set noshowmode
        set noruler
        set laststatus=0
        set noshowcmd
        set cmdheight=1
        set showtabline=0
        set nonumber
        set colorcolumn=
    else
        let s:hidden_all = 0
        set showmode
        set ruler
        set laststatus=2
        set showcmd
        set cmdheight=2
        set showtabline=1
        set number
        set colorcolumn=98
    endif
endfunction

nnoremap <S-h> :call ToggleHiddenAll()<CR>
call ToggleHiddenAll()

" autocmd FileType elixir imap ii  IO.inspect()<esc>ha
" autocmd FileType elixir imap \|ii  \|> IO.inspect()<esc>ha
" autocmd FileType elixir imap \|il  \|> IO.inspect(label: )<esc>ha

" vim-elixir
augroup elixir_custom_syntax
  autocmd!
  autocmd Syntax elixir call s:elixir_syntax_patch()
augroup END

function! s:elixir_syntax_patch()
  syntax clear elixirSigil
  syntax clear elixirHeexSigil

  " ~HTML
  unlet! b:current_syntax
  syntax region elixirHtmlSigilTripleDouble matchgroup=elixirSigilDelimiter keepend start=+^\s*\~HTML\z("""\)+ skip=+\\"+ end=+^\s*\z1+ contains=@html fold
  syntax region elixirHtmlSigilDouble matchgroup=elixirSigilDelimiter keepend start=+\~HTML"+ skip=+\\"+ end=+"+ contains=@html
  syntax region elixirHtmlSigilBrace matchgroup=elixirSigilDelimiter keepend start=+\~HTML{+ end=+}+ contains=@html
  syntax cluster elixirTemplateSigils add=elixirHtmlSigilTripleDouble,elixirHtmlSigilDouble,elixirHtmlSigilBrace

  " ~JS
  unlet! b:current_syntax
  syntax include @javascript syntax/javascript.vim
  syntax region elixirJsSigilTripleDouble matchgroup=elixirSigilDelimiter keepend start=+^\s*\~JS\z("""\)+ skip=+\\"+ end=+^\s*\z1+ contains=@javascript fold
  syntax region elixirJsSigilDouble matchgroup=elixirSigilDelimiter keepend start=+\~JS"+ skip=+\\"+ end=+"+ contains=@javascript
  syntax cluster elixirTemplateSigils add=elixirJsSigilTripleDouble,elixirJsSigilDouble

  " ~PY
  unlet! b:current_syntax
  syntax include @python syntax/python.vim
  syntax region elixirPySigilTripleDouble matchgroup=elixirSigilDelimiter keepend start=+^\s*\~PY\z("""\)+ skip=+\\"+ end=+^\s*\z1+ contains=@python fold
  syntax region elixirPySigilDouble matchgroup=elixirSigilDelimiter keepend start=+\~PY"+ skip=+\\"+ end=+"+ contains=@python
  syntax cluster elixirTemplateSigils add=elixirPySigilTripleDouble,elixirPySigilDouble

  " ~SQL
  unlet! b:current_syntax
  syntax include @sql syntax/sql.vim
  syntax region elixirSqlSigilTripleDouble matchgroup=elixirSigilDelimiter keepend start=+^\s*\~SQL\z("""\)+ skip=+\\"+ end=+^\s*\z1+ contains=@sql fold
  syntax region elixirSqlSigilDouble matchgroup=elixirSigilDelimiter keepend start=+\~SQL"+ skip=+\\"+ end=+"+ contains=@sql
  syntax cluster elixirTemplateSigils add=elixirSqlSigilTripleDouble,elixirSqlSigilDouble
endfunction














" Old

"Plug 'editorconfig/editorconfig-vim'
"Plug 'bogado/file-line'
"Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
"Plug 'junegunn/fzf.vim'
"Plug 'elixir-lang/vim-elixir'
"Plug 'slashmili/alchemist.vim', {'for': 'elixir'}
"Plug 'jremmen/vim-ripgrep'
"Plug 'wojtekmach/vim-test', {'branch': 'wm-erlang-eunit'}
"" Plug 'wojtekmach/vim-test', {'dir': '~/src/oss/vim-test'}
"" Plug 'janko-m/vim-test'
"Plug 'kien/ctrlp.vim'
"Plug 'scrooloose/nerdtree'
"Plug 'tpope/vim-fugitive'
"Plug 'tpope/vim-commentary'
"Plug 'tpope/vim-rhubarb'
"Plug 'tpope/vim-projectionist'
"Plug 'tpope/vim-dispatch'
"Plug 'tpope/vim-endwise'
"Plug 'rizzatti/dash.vim'
"Plug 'rizzatti/dash.vim'
"Plug 'mattn/webapi-vim'
"Plug 'mattn/gist-vim'
"Plug 'zanloy/vim-colors-grb256'
"Plug 'wlangstroth/vim-racket'
"Plug 'endel/vim-github-colorscheme'
"Plug 'altercation/vim-colors-solarized'
"call plug#end()

"set nocompatible
"" allow unsaved background buffers and remember marks/undo for them
"set hidden
"" remember more commands and search history
"set history=10000
"set expandtab
"set tabstop=2
"set shiftwidth=2
"set softtabstop=2
"set autoindent
"set laststatus=2
"set showmatch
"set incsearch
"set hlsearch
"set textwidth=98
"" list
"set list
"set listchars=tab:⎵·,trail:␠,nbsp:⎵
"" make searches case-sensitive only if they contain upper-case characters
"set ignorecase smartcase
"set cmdheight=2
"set switchbuf=useopen
"set numberwidth=5
"set showtabline=2
"set winwidth=79
"" This makes RVM work inside Vim. I have no idea why.
"set shell=bash
"" Prevent Vim from clobbering the scrollback buffer. See
"" http://www.shallowsky.com/linux/noaltscreen.html
"set t_ti= t_te=
"" keep more context when scrolling off the end of a buffer
"set scrolloff=3
"" Store temporary files in a central spot
"set backup
"set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
"" allow backspacing over everything in insert mode
"set backspace=indent,eol,start
"" display incomplete commands
"set showcmd
"" Enable highlighting for syntax
"syntax on
"" Enable file type detection.
"" Use the default filetype settings, so that mail gets 'tw' set to 72,
"" 'cindent' is on in C files, etc.
"" Also load indent files, to automatically do language-dependent indenting.
"filetype plugin indent on
"" use emacs-style tab completion when selecting files, etc
"set wildmode=longest,list
"" make tab completion for files/buffers act like bash
"set wildmenu
"let mapleader=","

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" STATUS LINE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
":set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" MULTIPURPOSE TAB KEY
"" Indent if we're at the beginning of a line. Else, do completion.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! InsertTabWrapper()
"    let col = col('.') - 1
"    if !col || getline('.')[col - 1] !~ '\k'
"        return "\<tab>"
"    else
"        return "\<c-p>"
"    endif
"endfunction
"inoremap <tab> <c-r>=InsertTabWrapper()<cr>
"inoremap <s-tab> <c-n>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" RENAME CURRENT FILE
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"function! RenameFile()
"    let old_name = expand('%')
"    let new_name = input('New file name: ', expand('%'), 'file')
"    if new_name != '' && new_name != old_name
"        exec ':saveas ' . new_name
"        exec ':silent !rm ' . old_name
"        redraw!
"    endif
"endfunction
"map <leader>n :call RenameFile()<cr>

"" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" " OPEN ALTERNATE FILE
"" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"" function! ExOpenTestAlternate()
""   let new_file = ExAlternateForCurrentFile()
""   exec ':e ' . new_file
"" endfunction
"" function! ExAlternateForCurrentFile()
""   let current_file = expand("%")
""   let new_file = current_file
""   let in_spec = match(current_file, 'test/') != -1
""   let going_to_spec = !in_spec
""   let in_web = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
""   let in_umbrella = match(current_file, '\apps') != -1
""   if going_to_spec
""     if in_web && in_umbrella
""       let new_file = substitute(new_file, '\/web', '\/test', '')
""     end
""     let new_file = substitute(new_file, 'lib/', 'test/', '')
""     let new_file = substitute(new_file, '\.ex$', '_test.exs', '')
""   else
""     let new_file = substitute(new_file, '_test\.exs$', '.ex', '')

""     if in_web && in_umbrella
""       let new_file = substitute(new_file, 'test/', 'web/', '')
""     else
""       let new_file = substitute(new_file, 'test/', 'lib/', '')
""     end
""   endif
""   return new_file
"" endfunction
"nnoremap <leader>, :A<CR>

""""""""""""""""""""""
"" ack.vim
""""""""""""""""""""""
"let g:ackprg = 'ag --nogroup --nocolor --column'
"let g:ackprg = 'ag --vimgrep'

""""""""""""""""""""""
"" vim-test
""""""""""""""""""""""
"nmap <silent> T :wa\|:TestNearest<CR>
"nmap <silent> t :wa\|:TestFile<CR>
"nmap <silent> <leader>a :wa\|:TestSuite<CR>
"nmap <silent> <leader>l :wa\|:TestLast<CR>
"nmap <silent> e :wa\|:TestLast<CR>
"nmap <silent> <leader>g :wa\|:TestVisit<CR>

"function! CustomTransform(cmd) abort
"  return substitute(a:cmd, 'mix test', 't', '')
"endfunction

"let g:test#preserve_screen = 0
"let g:test#custom_transformations = {'custom': function('CustomTransform')}
"let g:test#transformation = 'custom'

""""""""""""""""""""""
"" vim-gist
""""""""""""""""""""""
"let g:gist_post_private = 1

""""""""""""""""""""""
"" vim-projectionist
""""""""""""""""""""""

"let g:projectionist_heuristics = {
"    \   ".elixir_core": {
"    \     "lib/elixir/lib/*.ex": { "alternate": "lib/elixir/test/elixir/{}_test.exs", "type": "source" },
"    \     "lib/elixir/test/elixir/*_test.exs": { "alternate": "lib/elixir/lib/{}.ex", "type": "source" }
"    \   },
"    \   "rebar.config": {
"    \     "src/*.erl": { "alternate": "test/{}_tests.erl", "type": "source" },
"    \     "test/*_tests.erl": { "alternate": "src/{}.erl", "type": "source" }
"    \   },
"    \   "mix.exs": {
"    \     "web/*.ex": { "alternate": "test/{}_test.exs", "type": "source" },
"    \     "test/controllers/*_test.exs":  { "alternate": "web/controllers/{}.ex", "type": "test" },
"    \     "test/views/*_test.exs":  { "alternate": "web/views/{}.ex", "type": "test" },
"    \     "test/plugs/*_test.exs":  { "alternate": "web/plugs/{}.ex", "type": "test" },
"    \     "lib/*.ex":        { "alternate": "test/{}_test.exs", "type": "source" },
"    \     "test/*_test.exs": { "alternate": "lib/{}.ex", "type": "test" },
"    \   },
"    \ }

""""""""""""""""""""""
"" random
""""""""""""""""""""""

"let NERDTreeShowHidden=1

"autocmd BufRead,BufNewFile   *.erl,*.hrl setlocal sw=4 sts=4 et
"set number

"" https://vi.stackexchange.com/a/679
"augroup Mkdir
"  autocmd!
"  autocmd BufWritePre *
"    \ if !isdirectory(expand("<afile>:p:h")) |
"        \ call mkdir(expand("<afile>:p:h"), "p") |
"    \ endif
"augroup END


"let s:hidden_all = 0
"function! ToggleHiddenAll()
"    if s:hidden_all  == 0
"        let s:hidden_all = 1
"        set noshowmode
"        set noruler
"        set laststatus=0
"        set noshowcmd
"        set cmdheight=1
"        set showtabline=0
"        set nonumber
"    else
"        let s:hidden_all = 0
"        set showmode
"        set ruler
"        set laststatus=2
"        set showcmd
"        set cmdheight=2
"        set showtabline=1
"        set number
"    endif
"endfunction

"nnoremap <S-h> :call ToggleHiddenAll()<CR>
"" call ToggleHiddenAll()

"colorscheme wojtek
"highlight! EndOfBuffer ctermfg=white
"let g:ctrlp_custom_ignore = 'node_modules\|git\|_build\|deps\|priv/static'

"function! WinZoomToggle() abort
"  if !exists('w:WinZoomIsZoomed') 
"    let w:WinZoomIsZoomed = 0
"  endif
"  if w:WinZoomIsZoomed == 0
"    execute "tabedit %"
"    let w:WinZoomIsZoomed = 1
"  elseif w:WinZoomIsZoomed == 1
"    execute "tabclose"
"    let w:WinZoomIsZoomed = 0
"  endif
"endfunction

"nmap <leader>z :call WinZoomToggle()<cr>

"noremap c[ :w\|:cprev<CR>
"noremap c] :w\|:cnext<CR>
"nnoremap <C-a> 0
"nnoremap <C-e> $
"inoremap <C-a> <Esc>0
"inoremap <C-e> <Esc>$
