"
" $HOME/.vimrc -- a configuration file for Vi IMproved
"

" General settings:
set nocompatible                  " Disable Vi-compatible mode.
set magic                         " Use classic regular expressions.
set noignorecase                  " Be case sensitive.
set wrapscan                      " Search across multiple lines.
set backupcopy=no                 " Do not create backup copies.
set formatoptions=tcqr            " Adjust automatic formatting.
set backspace=indent,eol,start    " Specify the backspace behavior.
set history=1000                  " Specify the number of possible undos.
set helplang=en                   " Specify the help language.
"set spelllang=en_us               " Specify the spell checking language.
set nospell                       " Disable spell checking by default.
filetype off                      " Enable file type detection.
set guifont=Inconsolata\ 12
set shell=/bin/bash

" Environment settings:
set ruler                         " Display the ruler.
set showcmd                       " Display commands.
set showmode                      " Display the current mode.
set number                        " Display line numbers.
set hlsearch                      " Highlight all matching patterns.
set incsearch                     " Highlight matching text while typing.
"set list                          " Highlight tabs and trailing spaces
syntax on                         " Highlight the syntax.

" Ctrl-l redraws the screen and removes any search highlighting.
noremap <silent> <C-l> :nohl<CR><C-l>

" Editing settings:
set textwidth=0                   " Do not set the default text width.
set wrap                          " Wrap the displayed text.
set linebreak                     " Break lines at a word boundary.
set expandtab                     " Replace tabulators with spaces.
set tabstop=2                     " Set the number of spaces for a tabulator.
set shiftwidth=2                  " Set the number of spaces for indentation.
set autoindent                    " Automatically insert line breaks.
set nojoinspaces                  " Do not insert a second space after
                                  " a sentence when joining lines.
set laststatus=2                  " Display airline with one open window
"set lazyredraw

set encoding=UTF-8

" folding
set foldmethod=indent
set foldlevelstart=99

" for code navigation
set tags=~/Documents/robottelo/tags

" toggling tagbar
nnoremap <F4> :TagbarToggle<CR>

" Enable folding with the spacebar
nnoremap <space> za

" Required by the markdown folding plug-in
if has("autocmd")
    filetype plugin indent on
endif

" Case sensitivity for filename completion
if exists("&wildignorecase")
    set wildignorecase
endif

" Stronger highlighting for review process
nnoremap <buffer> <F9> :highlight SpellBad term=reverse guibg=Red guifg=White<cr>
"nnoremap <buffer> <F9> call StrongerErrorHighlight() <cr>
nnoremap <buffer> <F10> :so .vimrc<cr>

" Enhance the vertical movement over wrapped text:
noremap k gk
noremap j gj
noremap <Up> g<Up>
noremap <Down> g<Down>
inoremap <Up> <Esc>g<Up>a
inoremap <Down> <Esc>g<Down>a

" Another escape
inoremap jj <Esc>

" yank deduplication
nnoremap <S-y> yaw

" CTRL-Tab is Next window
noremap  <C-Tab> <C-W>w
inoremap <C-Tab> <C-O><C-W>w
cnoremap <C-Tab> <C-C><C-W>w
inoremap <C-Z>  <C-O>u

" CTRL-X is Cut
vnoremap <C-X> "+x

" CTRL-C is Copy
vnoremap <C-C> "+y<Esc>

" CTRL-V and SHIFT-Insert are Paste
nnoremap <silent> <SID>Paste "=@+.'xy'<CR>gPFx"_2x
map  <S-Insert>         <SID>Paste
noremap  <C-P>          "+P
imap <C-P>              x<Esc><SID>Paste"_s
imap <S-Insert>         x<Esc><SID>Paste"_s
cmap <C-P>              <C-R>+
cmap <S-Insert>         <C-R>+
vmap <C-P>              "-cx<Esc><SID>Paste"_x

" F9 is make:
" nmap <F9> :make<CR>
" imap <F9> <ESC>:make<CR>
" cmap <F9> <ESC>:make<CR>

" ALT-J and ALT-K switch buffers
nnoremap <silent> <M-j> :bprevious<CR>
nnoremap <silent> <M-k> :bnext<CR>

" CTRL-direction switches between split windows
nnoremap <silent> <C-J> <C-W><C-J>
nnoremap <silent> <C-K> <C-W><C-K>
nnoremap <silent> <M-l> <C-W><C-L>
nnoremap <silent> <M-h> <C-W><C-H>

" ALT-C closes buffer but leaves the split window open on the next buff
nnoremap <silent> <M-c> :bp\|bd #<CR>

" Customize file type recognition
au BufNewFile,BufRead *.rng set ft=rng
au BufNewFile,BufRead *.page set ft=mallard
au BufNewFile,BufRead *.page.stub set ft=mallard
au BufNewFile,BufRead *.contentspec set ft=contentspec
au BufNewFile,BufRead *.txt set ft=txt
au BufNewFile,BufRead *.md set ft=markdown
au BufNewFile,BufRead *.adoc set ft=asciidoc
au FileType pandoc set ts=4 sw=4 expandtab
au FileType python set ts=4 sw=4 expandtab

" Configure thei plug plug-in manager:
call  plug#begin()

" Configure plugins:
Plug 'airblade/vim-gitgutter'
Plug 'gmarik/vundle'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'sickill/vim-pasta'
Plug 'tpope/vim-scriptease'
Plug 'chrisbra/Recover.vim'
Plug 'dahu/vim-asciidoc'
""Plug 'tpope/vim-fugitive'
Plug 'easymotion/vim-easymotion'
Plug 'Raimondi/delimitMate'
Plug 'pangloss/vim-javascript'
Plug 'tpope/vim-surround'
Plug 'Shutnik/jshint2.vim'
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'
Plug 'majutsushi/tagbar'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'tomtom/tcomment_vim'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-rails'
Plug 'mihaifm/vimpanel'
Plug 'lifepillar/vim-solarized8'
Plug 'vim-voom/voom'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'scrooloose/nerdcommenter'


"Plug 'ycm-core/YouCompleteMe'

"Plugin 'jhradilek/vim-docbk'
"Plugin 'jhradilek/vim-mallard'
"Plugin 'jhradilek/vim-pressgang'
"Plugin 'jhradilek/vim-rng'

"Plugin 'davidhalter/jedi-vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic' pomale
"Plugin 'nvie/vim-flake8'
"
"Plugin 'xolox/vim-misc'
"Plugin 'ternjs/tern_for_vim'
"Plugin 'xolox/vim-easytags' slow
"Plugin 'SirVer/ultisnips'
"Plugin 'jhradilek/vim-snippets'
"Plugin 'helino/vim-json'

" Tried but turned off
"Plugin 'luochen1990/rainbow'
"Plugin 'tpope/vim-surround'
"Plugin 'junegunn/goyo.vim'
"Plugin 'junegunn/limelight.vim'
"Plugin 'emender/emender-vim'
"Plugin 'ntpeters/vim-better-whitespace'
"Plugin 'nelstrom/vim-markdown-folding'
"Plugin 'vim-scripts/SearchComplete'
"Plugin 'mattn/emmet-vim'
"Plugin 'fholgado/minibufexpl.vim'

" To be explored
"chrisbra/NrrwRgn
"chrisbra/Colorizer
"chrisbra/vim-show-whitespace
"
call  plug#end()
filetype plugin indent on     "Enable automatic indentation.

" Configure the neosnippet plug-in:
imap <tab>     <Plug>(neosnippet_expand_or_jump)
smap <tab>     <Plug>(neosnippet_expand_or_jump)
xmap <tab>     <Plug>(neosnippet_expand_target)
let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.vim/bundle/vim-snippets/snippets'
let g:neosnippet#snippets_directory='~/.vim/bundle/my-snippets/snippets'

" fzf settings
set rtp+=~/.fzf
nnoremap <c-b> :Buffers<CR> 
nnoremap <c-h> :History<CR>

" Configure the easymotion plug-in
map <\> <Plug>(easymotion-prefix)

" Enable neocomplete on startup:
let g:neocomplete#enable_at_startup = 1

" Configure the UltiSnips plug-in:
"let g:UltiSnipsSnippetDirectories=["UltiSnips"]
"
"let g:UltiSnipsEditSplit = 'vertical'
"let g:UltiSnipsExpandTrigger = '<tab>'
"let g:UltiSnipsJumpForwardTrigger = '<s-tab>'
"let g:UltiSnipsJumpBackwardTrigger = '<c-s-tab>'

""" Configure the NERDTree plug-in:
let g:NERDTreeWinPos = 'left'     " Place the window to the left.
let g:NERDTreeWinSize = 30        " Change the window width.

" Start NERDTree in selected folder
" type C in nerdtree to change root at runtime
" U to go up a tree
function! StartUp()
    if 0 == argc()
        NERDTree ~/Documents/PROJECTS
    endif
endfunction

autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p

" NERDTree ignores pyc files
let g:NERDTreeIgnore = ['\.pyc$']
let g:NERDTreeIgnore = ['^node_modules$']

" NERDTree toggles with f11
nmap <silent> <F11>  :NERDTreeToggle<CR>
imap <silent> <F11> <ESC>:NERDTreeToggle<CR>
cmap <silent> <F11> <ESC>:NERDTreeToggle<CR>

" close NERDTree when closing vim
autocmd VimLeave * NERDTreeClose
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Prettier NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Hide brackets in NERDTree status 
let g:NERDTreeGitStatusConcealBrackets = 1

" Configure the vim-airline plug-in
let g:airline_theme             = 'molokai'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline#extensions#tabline#enabled = 1

" Enable gitgutter by defaut
let g:gitgutter_enabled = 1
let g:gitgutter_toggle = 1
let g:gitgutter_async = 0

" vim-airline symbols
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'


cmap w!! %!sudo tee > /dev/null

" COC settings
"completion with import
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Give more space for displaying messages.
set cmdheight=2
" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction


" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
"nmap <leader>F2 <Plug>(coc-rename)

" pretier config
command! -nargs=0 Prettier :CocCommand prettier.formatFile
" run prettier on save
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.vue,*.yaml,*.html Prettier


"folow symlink if opening it
function! MyFollowSymlink(...)
    if exists('w:no_resolve_symlink') && w:no_resolve_symlink
        return
    endif
    if &ft == 'help'
        return
    endif
    let fname = a:0 ? a:1 : expand('%')
    let fname = simplify(fname)

    let resolvedfile = resolve(fname)
    if resolvedfile == fname
        return
    endif
    let resolvedfile = fnameescape(resolvedfile)
    redraw  " Redraw now, to avoid hit-enter prompt.
    exec 'file ' . resolvedfile

    if &modifiable
        " Only display a note when editing a file, especially not for `:help`.
        redraw  " Redraw now, to avoid hit-enter prompt.
        echomsg 'Resolved symlink: =>' resolvedfile
    endif
endfunction

command! -bar FollowSymlink call MyFollowSymlink()
command! ToggleFollowSymlink let w:no_resolve_symlink = !get(w:, 'no_resolve_symlink', 0) | echo "w:no_resolve_symlink =>" w:no_resolve_symlink
au BufReadPost * nested call MyFollowSymlink(expand('%'))

finish
