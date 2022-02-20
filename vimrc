"TODO coc shortcuts fuzzy finder ...
set fileformat=unix
let mapleader = " "
"Plugins
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "https://github.com/neoclide/coc.nvim
Plug 'szw/vim-maximizer'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
call plug#end()
	"coc.vim
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-clangd',
			\ 'coc-go', 'coc-pyright', 'coc-html', 'coc-css']
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap rn <Plug>(coc-rename)
map <silent> <leader>e :CocDiagnostics <Enter>
nmap <leader>x :CocFix <Enter>
	"vim-maximizer
map <leader>m :MaximizerToggle<Enter>
"general things
filetype on
filetype plugin indent on
syntax on
set updatetime=1000
set tabstop=4
set shiftwidth=4
set spell
set breakindent
set clipboard=unnamedplus
set incsearch "highlights search
set number
set cursorline
set wildmode=longest,list,full
colorscheme nord
autocmd InsertEnter * norm 5jzz5k
autocmd BufWritePre * %s/\s\+$//e
"general bindings
imap gg <Esc>
	"splits
map <C-n> <Esc>:vnew<Enter>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
"code editing helpers
imap {{ {<Enter>}<Esc>ko
imap (( () <++><Esc>5hi
imap [[ [] <++><Esc>5hi
nnoremap <Del> %d``dl
imap "" "" <++><Esc>5hi
imap '' '' <++><Esc>5hi
imap <> <> <++><Esc>5hi
imap jj <++>
imap kk <Esc>/<++><Enter>v3ldi
"c c++
autocmd FileType c,cpp
	\ imap // /*  */<Esc>hhi
"go
autocmd FileType go
	\ imap // /*  */<Esc>hhi
"html
autocmd FileType html,css
	\ set tabstop=2
autocmd FileType html,css
	\ set shiftwidth=2
