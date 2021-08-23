" 
"~~~~~~~~~~~~~~~~~~~~~~~~~~~
" ~ Patrick's custom vimrc ~
" ~     The good stuff     ~
"~~~~~~~~~~~~~~~~~~~~~~~~~~~

colorscheme elflord

" I can't freaking type
command W w
command Q q

" This ain't Twitter
set tabstop=4
set smarttab
set expandtab
set autoindent
set number
filetype indent plugin on

" ------
" Colors
" ------
set hlsearch
syntax on

" Vimdiff colors
if &diff
    colorscheme elflord
endif

" Make Xcode project file merge conflicts actually readable
au BufRead,BufNewFile *.pbxproj set filetype=pbxproj
autocmd Filetype pbxproj setlocal nowrap  
