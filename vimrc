call plug#begin('~/.vim/plugged')
 Plug 'w0rp/ale'
 Plug 'vim-airline/vim-airline'
 Plug 'ctrlpvim/ctrlp.vim'
 Plug 'vim-airline/vim-airline-themes'
" commenting Plug 'Shougo/deoplete.nvim'
 Plug 'Shougo/echodoc'
 if has('nvim')
   Plug 'Shougo/denite.nvim, { 'do': ':UpdateRemotePlugins' }
 else
  Plug 'Shougo/denite.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
 endif
 Plug 'purescript-contrib/purescript-vim'
 Plug 'neoclide/coc.nvim', {'branch': 'release'}
 Plug 'dhruvasagar/vim-table-mode'
 Plug 'preservim/nerdtree'
 Plug 'purescript-contrib/purescript-vim'
call plug#end()
set ts=2
set si
set ai
set expandtab
set history=10000
set hlsearch
set sw=2

set title
set titlestring=VIM:\ %-25.55t\ %a%r%m titlelen=70

hi LineNr       term=bold cterm=none ctermfg=DarkGrey guifg=Grey guibg=Grey90

nnoremap <SPACE> <Nop>
let mapleader=" "

let g:airline_powerline_fonts = 1

let g:prettier#autoformat = 0
if filereadable(findfile('.prettierrc.js', '.;'))
  echo "Using prettier..."
  autocmd BufWritePre *.js,*.jsx,*mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
endif

let g:ale_linters = {
 \ 'javascript': ['eslint']
 \ }
let g:ale_fixers = {
 \ 'javascript': ['prettier', 'eslint']
 \ }

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1

" Bind F8 to fixing problems with ALE
nmap <F8> <Plug>(ale_fix)

let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

let g:ale_lint_on_save = 1
let g:ale_fix_on_save = 1
let g:ale_sign_column_always = 1

" Enable the list of buffers
let g:airline#extensions#tabline#enabled = 1

" Show just the filename
let g:airline#extensions#tabline#fnamemod = ':t'
let g:airline#extensions#tabline#buffer_nr_show = 1
let g:airline#extensions#ale#enabled = 1

" To open a new empty buffer
" This replaces :tabnew which I used to bind to this mapping
nmap <leader>T :enew<cr>
" Move to the next buffer
nmap <leader>l :bnext<CR>
" Move to the previous buffer
nmap <leader>h :bprevious<CR>
" Delete the current buffer
nmap <leader>d :bdelete<CR>
" Toggle mouse mode on
map <F3> <ESC>:exec &mouse!=""? "set mouse=" : "set mouse=nv"<CR>

" Toggle between prev file
nmap <leader>k <C-6>
nmap <leader>tm :TableModeToggle

nmap gk <C-6>
nnoremap ge :Texplore<CR>
nnoremap gn :tabnew<CR>
nnoremap gm :tab term<CR>
nnoremap gb :tabprev<CR>
nnoremap gh :tabprev<CR>
nnoremap gl :tabnext<CR>

"  deoplete starts --------------------------------------------------------
" let g:deoplete#enable_at_startup = 0
set cmdheight=2
let g:echodoc_enable_at_startup = 1
" let g:echodoc#type = 'floating'

" Set Enter to select the option. NOT used. Using tab below
" call deoplete#custom#option('on_insert_enter', v:true)

" <TAB>: completion for deoplete
" (https://github.com/Shougo/deoplete.nvim/issues/816)
" inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"

" Q: I want to close the preview window after completion is done.
" https://github.com/Shougo/deoplete.nvim/blob/master/doc/deoplete.txt
" autocmd CompleteDone * silent! pclose!
"  deoplete ends --------------------------------------------------------
"
"
"  coc.nvim starts --------------------------------------------------------
"  Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved
set signcolumn=yes
"  " Use tab for trigger completion with characters ahead and navigate
" NOTE: There's always complete item selected by default, you may want to enable
" no select by `"suggest.noselect": true` in your configuration file
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"

" Make <CR> to accept selected completion item or notify coc.nvim to format
" <C-g>u breaks current undo, please make your own choice
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                               \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction
" Use <c-space> to trigger completion
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif
"  coc.nvim ends --------------------------------------------------------
