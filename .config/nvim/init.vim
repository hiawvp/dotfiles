set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath

" Turn on syntax highlighting.
syntax on

" Disable the default Vim startup message.
set shortmess+=I

" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" " UI Config
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set cursorline          " highlight current line
set showmatch           " highlight matching [{()}]
set mouse+=a            " A necessary evil, mouse support
set splitbelow          " Open new vertical split bottom
set splitright          " Open new horizontal splits right
set linebreak           " Have lines wrap instead of continue off-screen
set scrolloff=12        " Keep cursor in approximately the middle of the screen


" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase


" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=
set clipboard=unnamed

call plug#begin()

Plug 'lervag/vimtex'
Plug 'scrooloose/nerdcommenter'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'rafamadriz/friendly-snippets'
Plug 'christoomey/vim-tmux-navigator'
Plug 'NLKNguyen/papercolor-theme'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-obsession'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'whatyouhide/vim-gotham'
Plug 'fatih/molokai'
Plug 'morhetz/gruvbox'
Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'rust-lang/rust.vim'

call plug#end()

" Spaces & Tabs
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set tabstop=4       " number of visual spaces per TAB
set softtabstop=4   " number of spaces in tab when editing
set shiftwidth=4    " Insert 4 spaces on a tab
set expandtab       " tabs are spaces, mainly because of python
"
"
"colorscheme gruvbox
colorscheme molokai
"colorscheme PaperColor
"colorscheme dracula
let g:lightline = { 'colorscheme': 'one' }
"set background=dark
set background=light


" golang colorschemes
let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1


let g:vrc_set_default_mapping = 0
"{{ Configuring NerdTree
"" ---> to hide unwanted files <---
let NERDTreeIgnore = [ '__pycache__', '\.pyc$', '\.o$', '\.swp',  '*\.swp',  'node_modules/' ]
" ---> show hidden files <---
let NERDTreeShowHidden=1
" ---> autostart nerd-tree when you start vim <---
"autocmd vimenter * NERDTree

" Start NERDTree when Vim is started without file arguments.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" ---> toggling nerd-tree using Ctrl-N <---
map <C-n> :NERDTreeToggle<CR>
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif
"}}
" ctrlp ignore dirs
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target\|tmp'

"{{ Configuring coc
" GoTo code navigation.

"Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
"inoremap <silent><expr> <TAB>
       "\ pumvisible() ? "\<C-n>" :
       "\ CheckBackspace() ? "\<TAB>" :
       "\ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

"function! CheckBackspace() abort
    "let col = col('.') - 1
    "return !col || getline('.')[col - 1]  =~# '\s'
"endfunction

"" Use <c-space> to trigger completion.
"inoremap <silent><expr> <c-space> coc#refresh()

"" Make <CR> auto-select the first completion item and notify coc.nvim to
"" format on enter, <cr> could be remapped by other vim plugin
"inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
            "\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
"}}
"
"
"
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm() : "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
inoremap <silent><expr> <C-x><C-z> coc#pum#visible() ? coc#pum#stop() : "\<C-x>\<C-z>"
" remap for complete to use tab and <cr>
inoremap <silent><expr> <TAB>
            \ coc#pum#visible() ? coc#pum#next(1):
            \ <SID>check_back_space() ? "\<Tab>" :
            \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"
inoremap <silent><expr> <c-space> coc#refresh()

hi CocSearch ctermfg=12 guifg=#18A3FF
hi CocMenuSel ctermbg=109 guibg=#13354A

function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
" Highlight symbol under cursor on CursorHold
" autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_global_extensions = [
            \ 'coc-snippets',
            \ 'coc-pairs',
            \ 'coc-tsserver',
            \ 'coc-eslint', 
            \ 'coc-prettier', 
            \ 'coc-json', 
            \ ]

"}}
"some maps
let g:rustfmt_autosave = 1
nmap <leader>w :w!<cr>
nmap <leader>; A;<Esc>
"nnoremap <leader>p :set paste!<cr>
nnoremap <leader>p "+p<cr>
vmap <leader>y :w !xclip -selection clipboard <cr><cr>
vmap y ygv<Esc>
nnoremap <leader>n :NERDTreeFocus<CR>

" nerdcommenter
nmap <leader>c <plug>NERDCommenterToggle
vmap <leader>c <plug>NERDCommenterToggle
"nmap <C-/> <plug>NERDCommenterToggle

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader> h :CocCommand clangd.switchSourceHeader<CR>

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Symbol renaming.
nmap <leader>rr :CocCommand rust-analyzer.run <CR>

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>tt :call VrcQuery()<CR>
" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
"nnoremap ^[[1;3Ap:m .-2<CR>==
nmap <leader>] <Plug>(coc-diagnostic-next) 
"xmap <leader> ] <Plug>(coc-diagnostic-next) 
nmap <leader>[ :call CocAction('diagnosticPrevious')<CR>
"nmap <leader> [ <Plug>(coc-diagnostic-next) 
"try
    "nmap <silent> [c :call CocAction('diagnosticNext')<cr>
    "nmap <silent> ]c :call CocAction('diagnosticPrevious')<cr>
"endtry
"nmap <leader>] :call CocAction('diagnosticNext')<CR>
"xmap <leader>] :call CocAction('diagnosticNext')<CR>


function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return ""
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()
source ~/.vimrc
