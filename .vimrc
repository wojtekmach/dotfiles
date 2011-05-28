call pathogen#runtime_append_all_bundles()

color twilight
set guioptions-=T
set autoindent             " automatic indent new lines
set smartindent            " be smart about it
set nowrap                 " do not wrap lines
set softtabstop=2          " yep, two
set shiftwidth=2           " ..
set tabstop=4
set expandtab              " expand tabs to spaces
set nosmarttab             " fuck tabs
set formatoptions+=n       " support for numbered/bullet lists
set virtualedit=block      " allow virtual edit in visual block ..

if has("gui_running")
  " If the current buffer has never been saved, it will have no name,
  " call the file browser to save it, otherwise just save it.
  :map <silent> <C-S> :if expand("%") == ""<CR>:browse confirm w<CR>:else<CR>:confirm w<CR>:endif<CR>
endif
 imap <c-s> <c-o><c-s>

" tab navigation like firefox
nmap <C-S-tab> :tabprevious<CR>
nmap <C-tab> :tabnext<CR>
map <C-S-tab> :tabprevious<CR>
map <C-tab> :tabnext<CR>
imap <C-S-tab> <Esc>:tabprevious<CR>i
imap <C-tab> <Esc>:tabnext<CR>i
nmap <C-t> :tabnew<CR>
imap <C-t> <Esc>:tabnew<CR>

map <A-1> 1gt
map <A-2> 2gt
map <A-3> 3gt
map <A-4> 4gt
map <A-5> 5gt
map <A-6> 6gt
map <A-7> 7gt
map <A-8> 8gt
map <A-9> 9gt
map <A-0> 10g

imap <A-1> <Esc>1gt<CR>
imap <A-2> <Esc>2gt<CR>
imap <A-3> <Esc>3gt<CR>
imap <A-4> <Esc>4gt<CR>
imap <A-5> <Esc>5gt<CR>
imap <A-6> <Esc>6gt<CR>
imap <A-7> <Esc>7gt<CR>
imap <A-8> <Esc>8gt<CR>
imap <A-9> <Esc>9gt<CR>
imap <A-0> <Esc>10gt<CR>

nmap <D-V> "+p<CR>
cmap <D-V>  	<C-R>+

set number
"nmap <C-w> :bd<CR>
"imap <C-w> <Esc>:bd<CR>
