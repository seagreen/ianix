set shiftwidth=2
set tabstop=2

" Place a line at the 80th column.
set colorcolumn=80

" We use :command! instead of :command to define commands because
" the haskell.vim file is being sourced twice at startup and once
" each time a vim file is opened in a new tab -- if we don't use
" the exclamation mark we get this error:
"
"     Command already exists: add ! to replace it
"
" TODO: is there a place to put language specific code where it
" will only run once per vim session?

" A nice way to run https://github.com/jaspervdj/stylish-haskell from Vim.
:command! StylishHaskell :normal :%!stylish-haskell<ENTER>
