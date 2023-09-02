set fileformat=unix
set clipboard=unnamedplus
let mapleader = " "
"Plugins
call plug#begin('~/.vim/plugged')
Plug 'arcticicestudio/nord-vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'} "https://github.com/neoclide/coc.nvim
Plug 'lervag/vimtex'
Plug 'szw/vim-maximizer'
Plug 'airblade/vim-gitgutter'
Plug 'chrisbra/Colorizer'
Plug 'Exafunction/codeium.vim', { 'branch': 'main' }
call plug#end()
	"coc.vim
let g:coc_global_extensions = ['coc-json', 'coc-git', 'coc-clangd',
			\ 'coc-go', 'coc-pyright', 'coc-html', 'coc-css', 'coc-vimtex']
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1):
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice.
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
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
imap <M> <Esc>
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
autocmd BufNewFile,BufRead *.ino :set filetype=cpp

"Additional shortcuts
nmap tu :set tabstop=2 shiftwidth=2 expandtab<Enter>:%s/{/\r\t{/g<Enter>:%s/else/\r\telse/g<Enter>ggVG=
