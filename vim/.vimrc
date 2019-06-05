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
nnoremap yy yaw

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

" Configure the Vundle plug-in manager:
set rtp+=~/.vim/bundle/Vundle.vim
call  vundle#begin()

" Configure bundles:
Plugin 'airblade/vim-gitgutter'
Plugin 'gmarik/vundle'
"Plugin 'SirVer/ultisnips'
Plugin 'scrooloose/nerdtree'
"Plugin 'jhradilek/vim-snippets'
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'sickill/vim-pasta'
Plugin 'tpope/vim-scriptease'
Plugin 'chrisbra/Recover.vim'
Plugin 'dahu/vim-asciidoc'
Plugin 'tpope/vim-fugitive'
Plugin 'easymotion/vim-easymotion'
"Plugin 'helino/vim-json'
Plugin 'Raimondi/delimitMate'
Plugin 'pangloss/vim-javascript'
Plugin 'tpope/vim-surround'
Plugin 'Shutnik/jshint2.vim'
"Plugin 'ternjs/tern_for_vim'
Plugin 'Shougo/neocomplete.vim'
Plugin 'Shougo/neosnippet'
Plugin 'Shougo/neosnippet-snippets'
Plugin 'majutsushi/tagbar'
"Plugin 'xolox/vim-misc'
"Plugin 'xolox/vim-easytags' slow
Plugin 'junegunn/fzf'
Plugin 'junegunn/fzf.vim'
"Plugin 'grassdog/tagman.vim'
Plugin 'tomtom/tcomment_vim'
Plugin 'honza/vim-snippets'
Plugin 'tpope/vim-rails'
Plugin 'mihaifm/vimpanel'

"Plugin 'jhradilek/vim-docbk'
"Plugin 'jhradilek/vim-mallard'
"Plugin 'jhradilek/vim-pressgang'
"Plugin 'jhradilek/vim-rng'

"Plugin 'davidhalter/jedi-vim'
"Plugin 'Valloric/YouCompleteMe'
"Plugin 'scrooloose/syntastic' pomale
"Plugin 'nvie/vim-flake8'

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
call  vundle#end()
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
function! StartUp()
    if 0 == argc()
        NERDTree ~/Documents/robottelo
    endif
endfunction

autocmd VimEnter * call StartUp()
autocmd VimEnter * wincmd p

" NERDTree ignores pyc files
let NERDTreeIgnore = ['\.pyc$']

" NERDTree toggles with f11
" nmap <silent> <F11>  :NERDTreeToggle<CR>
" imap <silent> <F11> <ESC>:NERDTreeToggle<CR>
" cmap <silent> <F11> <ESC>:NERDTreeToggle<CR>

" Vimpanel toggles with f11
nmap <silent> <F11> :VimpanelToggleLeft myprojects<CR>
imap <silent> <F11> <ESC>:VimpanelToggleLeft myprojects<CR>
cmap <silent> <F11> <ESC>:VimpanelToggleLeft myprojects<CR>

" close NERDTree when closing vim
autocmd VimLeave * NERDTreeClose
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Prettier NERDTree
let NERDTreeMinimalUI = 1
let NERDTreeDirArrows = 1

" Configure the vim-airline plug-in
let g:airline_theme             = 'molokai'
let g:airline_enable_branch     = 1
let g:airline_enable_syntastic  = 1
let g:airline#extensions#tabline#enabled = 1

" vim-airline symbols
let g:airline_left_sep          = '⮀'
let g:airline_left_alt_sep      = '⮁'
let g:airline_right_sep         = '⮂'
let g:airline_right_alt_sep     = '⮃'
let g:airline_branch_prefix     = '⭠'
let g:airline_readonly_symbol   = '⭤'
let g:airline_linecolumn_prefix = '⭡'

" Configure the rainbow plug-in
let g:rainbow_active = 1


" Mini buffer explorer
"let g:miniBufExplModSelTarget = 1
"let g:miniBufExplorerMoreThanOne = 0
"let g:miniBufExplMapWindowNavArrows = 1
"let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplVSplit = 23
"let g:miniBufExplSplitBelow=1

"let g:miniBufExplMapWindowNavVim = 1
"let g:miniBufExplMapCTabSwitchBufs = 1

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
