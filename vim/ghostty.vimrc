call plug#begin('~/.vim/plugged')
Plug 'elixir-editors/vim-elixir'
Plug 'tpope/vim-commentary'
call plug#end()

autocmd BufWritePost *vimrc source %

set fillchars=eob:\ 

let mapleader = ","

" ,a
nnoremap <leader>a ggVG
vnoremap <leader>a <Esc>ggVG

" cmd+a
nnoremap <Esc>[98~ ggVG
vnoremap <Esc>[98~ <Esc>ggVG

" ,c
vnoremap <leader>c "+yy

" cmd+s
nnoremap <Esc>[99~ :w<CR>
vnoremap <Esc>[99~ <Esc>:w<CR>
inoremap <Esc>[99~ <Esc>:w<CR>gi

" cmd+/
nnoremap <Esc>[97~ :Commentary<CR>
vnoremap <Esc>[97~ :Commentary<CR>
