" vim:set ts=2 sts=2 sw=2 expandtab:
" Mostly stolen from https://github.com/garybernhardt/dotfiles/blob/master/.vimrc

call plug#begin('~/.vim/plugged')
Plug 'editorconfig/editorconfig-vim'
Plug 'elixir-lang/vim-elixir'
Plug 'slashmili/alchemist.vim', {'for': 'elixir'}
Plug 'mileszs/ack.vim'
Plug 'janko-m/vim-test'
Plug 'kien/ctrlp.vim'
Plug 'scrooloose/nerdtree'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-projectionist'
Plug 'rizzatti/dash.vim'
Plug 'rizzatti/dash.vim'
Plug 'mattn/webapi-vim'
Plug 'mattn/gist-vim'
call plug#end()

set nocompatible
" allow unsaved background buffers and remember marks/undo for them
set hidden
" remember more commands and search history
set history=10000
set expandtab
set tabstop=2
set shiftwidth=2
set softtabstop=2
set autoindent
set laststatus=2
set showmatch
set incsearch
set hlsearch
" make searches case-sensitive only if they contain upper-case characters
set ignorecase smartcase
set cmdheight=2
set switchbuf=useopen
set numberwidth=5
set showtabline=2
set winwidth=79
" This makes RVM work inside Vim. I have no idea why.
set shell=bash
" Prevent Vim from clobbering the scrollback buffer. See
" http://www.shallowsky.com/linux/noaltscreen.html
set t_ti= t_te=
" keep more context when scrolling off the end of a buffer
set scrolloff=3
" Store temporary files in a central spot
set backup
set backupdir=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
set directory=~/.vim-tmp,~/.tmp,~/tmp,/var/tmp,/tmp
" allow backspacing over everything in insert mode
set backspace=indent,eol,start
" display incomplete commands
set showcmd
" Enable highlighting for syntax
syntax on
" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on
" use emacs-style tab completion when selecting files, etc
set wildmode=longest,list
" make tab completion for files/buffers act like bash
set wildmenu
let mapleader=","

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" STATUS LINE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
:set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" RENAME CURRENT FILE
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
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

" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" " OPEN ALTERNATE FILE
" """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" function! ExOpenTestAlternate()
"   let new_file = ExAlternateForCurrentFile()
"   exec ':e ' . new_file
" endfunction
" function! ExAlternateForCurrentFile()
"   let current_file = expand("%")
"   let new_file = current_file
"   let in_spec = match(current_file, 'test/') != -1
"   let going_to_spec = !in_spec
"   let in_web = match(current_file, '\<controllers\>') != -1 || match(current_file, '\<views\>') != -1 || match(current_file, '\<helpers\>') != -1
"   let in_umbrella = match(current_file, '\apps') != -1
"   if going_to_spec
"     if in_web && in_umbrella
"       let new_file = substitute(new_file, '\/web', '\/test', '')
"     end
"     let new_file = substitute(new_file, 'lib/', 'test/', '')
"     let new_file = substitute(new_file, '\.ex$', '_test.exs', '')
"   else
"     let new_file = substitute(new_file, '_test\.exs$', '.ex', '')

"     if in_web && in_umbrella
"       let new_file = substitute(new_file, 'test/', 'web/', '')
"     else
"       let new_file = substitute(new_file, 'test/', 'lib/', '')
"     end
"   endif
"   return new_file
" endfunction
nnoremap <leader>, :A<CR>

"""""""""""""""""""""
" ack.vim
"""""""""""""""""""""
let g:ackprg = 'ag --nogroup --nocolor --column'
let g:ackprg = 'ag --vimgrep'

"""""""""""""""""""""
" vim-test
"""""""""""""""""""""
nmap <silent> T :wa\|:TestNearest<CR>
nmap <silent> t :wa\|:TestFile<CR>
nmap <silent> <leader>a :wa\|:TestSuite<CR>
nmap <silent> <leader>l :wa\|:TestLast<CR>
nmap <silent> <leader>g :wa\|:TestVisit<CR>

function! CustomTransform(cmd) abort
  if match(a:cmd, 'apps/') != -1
    return substitute(a:cmd, 'mix test apps/\([^/]*/\)', 'cd apps/\1 \&\& mix test ', '')
  elseif match(a:cmd, 'lib/eex') != -1 || match(a:cmd, 'lib/elixir') != -1 || match(a:cmd, 'lib/ex_unit') != -1 || match(a:cmd, 'lib/iex') != -1 || match(a:cmd, 'lib/logger') != -1 || match(a:cmd, 'lib/mix') != -1
    return substitute(a:cmd, 'mix test ', 'make compile \&\& bin/elixir ', '')
  else
    return a:cmd
  end
endfunction

let g:test#preserve_screen = 0
let g:test#custom_transformations = {'custom': function('CustomTransform')}
let g:test#transformation = 'custom'

"""""""""""""""""""""
" vim-gist
"""""""""""""""""""""
let g:gist_post_private = 1

"""""""""""""""""""""
" vim-projectionist
"""""""""""""""""""""

let g:projectionist_heuristics = {
    \   ".elixir_core": {
    \     "lib/elixir/lib/*.ex": { "alternate": "lib/elixir/test/elixir/{}_test.exs", "type": "source" },
    \     "lib/elixir/test/elixir/*_test.exs": { "alternate": "lib/elixir/lib/{}.ex", "type": "source" }
    \   },
    \   "mix.exs": {
    \     "web/*.ex": { "alternate": "test/{}_test.exs", "type": "source" },
    \     "test/controllers/*_test.exs":  { "alternate": "web/controllers/{}.ex", "type": "test" },
    \     "test/views/*_test.exs":  { "alternate": "web/views/{}.ex", "type": "test" },
    \     "test/plugs/*_test.exs":  { "alternate": "web/plugs/{}.ex", "type": "test" },
    \     "lib/*.ex":        { "alternate": "test/{}_test.exs", "type": "source" },
    \     "test/*_test.exs": { "alternate": "lib/{}.ex", "type": "test" },
    \   },
    \ }

"""""""""""""""""""""
" random
"""""""""""""""""""""

let NERDTreeShowHidden=1

noremap c[ :w\|:cprev<CR>
noremap c] :w\|:cnext<CR>
nnoremap <C-a> 0<CR>
nnoremap <C-e> $<CR>
inoremap <C-a> <Esc>0<CR>
inoremap <C-e> <Esc>$<CR>
