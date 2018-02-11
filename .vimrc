" 
"~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~ Patrick's custom vimrc ~
" ~ AKA Things that should ~
"  ~ be on by default :P  ~
"~~~~~~~~~~~~~~~~~~~~~~~~~~~

colorscheme elflord

" You know it's gonna happen 
command W w
command Q q

" This ain't Twitter
set tabstop=4
set smarttab
set expandtab
set autoindent

" ------
" Colors
" ------
set hlsearch
syntax on

" Vimdiff colors
if &diff
    colorscheme elflord
endif

