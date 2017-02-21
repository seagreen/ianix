set shiftwidth=2
set tabstop=2

" Place a line at the 80th column.
set colorcolumn=80

" From here:
" http://www.stephendiehl.com/posts/vim_2016.html
map <silent> tw :GhcModTypeInsert<CR>
map <silent> ts :GhcModSplitFunCase<CR>
map <silent> tq :GhcModType<CR>
map <silent> te :GhcModTypeClear<CR>

" Disable haskell-vim omnifunc
let g:haskellmode_completion_ghc = 1
autocmd FileType haskell setlocal omnifunc=necoghc#omnifunc

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
