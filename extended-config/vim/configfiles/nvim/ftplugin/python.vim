set expandtab
set shiftwidth=4
set tabstop=4

" colorscheme oceanblack256
" colorscheme softbluev2

" This is for 'airblade/vim-gitgutter' with oceanblack256 or softblue.
"
" highlight SignColumn ctermbg=black

" Place a line at the 80th column.
" set colorcolumn=80

" Old Vundle commands:
"
" Plugin 'davidhalter/jedi-vim'
" Plugin 'ervandew/supertab'
" " Tab scrolls down lists, not up
" let g:SuperTabDefaultCompletionType = "<c-n>"

" Creates the command :Ip which adds a line invoking ipdb and saves.
"
" Unless # is the first thing inserted in insert mode vim interprets it as a
" special character. Escaping it with backslash meant that it was interpreted
" normally, but for some reason the backslashes used showed up in the output.
:command Ip :normal i
    \import ipdb; ipdb.set_trace()
    \ <ESC>a# ------------------------ <ESC>a#
    \<ENTER><ESC>:w<ENTER>

" " Highlite lines over 79 characters.
" match Error /\%80v.\+/
