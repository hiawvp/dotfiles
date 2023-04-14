set runtimepath^=~/.vim runtimepath+=~/.vim/after
let &packpath = &runtimepath


call plug#begin()

Plug 'lervag/vimtex'
"cock
Plug 'neoclide/coc.nvim', {'branch': 'release'}


"nerdtree y plugins
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
"plugin que tira el error E5248
"Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
" navegacion con [c y ]c
Plug 'airblade/vim-gitgutter' 
"fuzzy finder
"Plug 'ctrlpvim/ctrlp.vim'
"leader c comments
Plug 'scrooloose/nerdcommenter'
"Plug 'rafamadriz/friendly-snippets'
Plug 'christoomey/vim-tmux-navigator'
"Plug 'tpope/vim-obsession'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
"Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-sleuth'

Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.1' }

"themes
"Plug 'dracula/vim', { 'name': 'dracula' }
"Plug 'morhetz/gruvbox'
Plug 'Mofiqul/dracula.nvim'
Plug 'itchyny/lightline.vim'
"Plug 'NLKNguyen/papercolor-theme'
Plug 'fatih/molokai'
"Plug 'dracula/vim', { 'name': 'dracula' }
Plug 'whatyouhide/vim-gotham'

"lang specific
Plug 'rust-lang/rust.vim'
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'heavenshell/vim-jsdoc', {
  \ 'for': ['javascript', 'javascript.jsx','typescript'],
  \ 'do': 'make install'
\}

Plug 'ckipp01/nvim-jenkinsfile-linter'
Plug 'martinda/Jenkinsfile-vim-syntax'
"Plug 'jackguo380/vim-lsp-cxx-highlight'

"Plug 'MarcWeber/vim-addon-mw-utils'
"Plug 'tomtom/tlib_vim'
"Plug 'garbas/vim-snipmate'

"Plugin 'honza/vim-snippets'

"Plug 'dccsillag/magma-nvim', { 'do': ':UpdateRemotePlugins' }
call plug#end()


lua << EOF

require'dracula'.setup {
  colors = {
    bg = '#110b33',
    selection = "#2c113d",
    -- selection = "#44475A",
  },
  show_end_of_buffer = true,
  transparent_bg = true,
  lualine_bg_color = '#44475a', 
  italic_comment = true
}
EOF


" You might have to force true color when using regular vim inside tmux as the
" colorscheme can appear to be grayscale with 'termguicolors' option enabled.
if !has('gui_running') && &term =~ '^\%(screen\|tmux\)'
  let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
  let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

syntax on
set termguicolors
colorscheme dracula

let g:lightline = {
            \ 'colorscheme': 'gotham',
            \ 'active': {
            \   'left': [ [ 'mode', 'paste' ],
            \             [ 'gitbranch', 'cocstatus', 'readonly', 'filename', 'modified' ] ]
            \ },
            \ 'component_function': {
            \   'gitbranch': 'FugitiveHead',
            \   'cocstatus': 'coc#status'
            \ },
            \ }

highlight Search cterm=NONE ctermfg=black ctermbg=darkblue guibg=DeepSkyBlue4 guifg=SkyBlue1

"golang colorschemes
let g:go_highlight_types = 1
"let g:go_highlight_fmolokai
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_extra_types = 1

let g:vrc_set_default_mapping = 0
let g:vimtex_view_general_viewer = 'evince'


lua << EOF
require'nvim-treesitter.configs'.setup {
    highlight = {
        enable = true,
    },
    indent = {
        enable = false,
    },
}
EOF

"{{ Configuring NerdTree
map <C-n> :NERDTreeToggle<CR>
nnoremap <leader>n :NERDTreeFocus<CR>
"" ---> to hide unwanted files <---
let NERDTreeIgnore = [ '__pycache__', '\.pyc$', '\.o$', '\.swp',  '*\.swp',  'node_modules/' ]
" ---> show hidden files <---
let NERDTreeShowHidden=1
" ---> autostart nerd-tree when you start vim <---
"autocmd vimenter * NERDTree

" Start NERDTree when Vim is started without file arguments.
"autocmd StdinReadPre * let s:std_in=1
"autocmd VimEnter * if argc() == 0 && !exists('s:std_in') | NERDTree | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif


" ctrlp ignore dirs
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|target\|tmp'

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
        call CocActionAsync('doHover')
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

let g:rustfmt_autosave = 1
"some plugin specific maps
"
"
nmap <leader>d <Plug>(jsdoc)

" nerdcommenter
"nmap <leader>c <plug>NERDCommenterToggle
"vmap <leader>c <plug>NERDCommenterToggle
nmap <C-_> <plug>NERDCommenterToggle
vmap <C-_> <plug>NERDCommenterToggle

"nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gd :call CocAction('jumpDefinition', 'tab drop')<CR>
nmap <silent> gv :call CocAction('jumpDefinition', v:false)<CR>
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

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

" telescope
" Find files using Telescope command-line sugar.
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <C-p> <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>



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

" CocInlayHint   xxx ctermfg=7 ctermbg=235 guifg=LightGrey guibg=#232526
hi CocInlayHint   ctermfg=32 ctermbg=17 guifg=DeepSkyBlue3 guibg=#232526

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')

function! JenkinsfileLinterValidate()
  call nvim_exec('lua require("jenkinsfile_linter").validate()', 0)
endfunction


command! -nargs=0 ValiJenk :call JenkinsfileLinterValidate()


source ~/.vimrc
