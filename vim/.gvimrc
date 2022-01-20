"
" $HOME/.gvimrc -- A configuration file for GTK Vi IMproved
"
" General settings:
set nospell                         " Enable spell checking.

" User interface settings:
set guioptions-=e                 " Disable all gui options
set guioptions-=T                 " Disable the toolbar.
set guioptions-=r                 " Disable the right-hand scrollbar.
set guioptions-=l                 " Disable the left-hand scrollbar.
set guioptions-=R                 " Disable the right-hand scrollbar in vertical split mode.
set guioptions-=L                 " Disable the left-hand scrollbar in vertical split mode.
set guioptions-=m                 " Disable the menu bar
set lines=55 columns=125          " Set the default window size
set guifont=Inconsolata\ Mediun\ 11  " Set the default font.
set background=dark
filetype plugin indent on
syntax on
set guifont=Inconsolata\ 12
colorscheme solarized8             " Set the default color scheme.

"remember latest session 
"sometimes causes trouble with syntax highlight
"put finish here to mitigate
set sessionoptions+=resize,winpos
autocmd VIMEnter * :source Session.vim
autocmd VIMLeave * :mksession! Session.vim

