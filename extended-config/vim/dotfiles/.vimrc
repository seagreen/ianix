"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'gmarik/Vundle.vim'

" Python
Plugin 'davidhalter/jedi-vim'
Plugin 'ervandew/supertab'
" Tab scrolls down lists, not up
let g:SuperTabDefaultCompletionType = "<c-n>"

" Haskell
Plugin 'bitc/vim-hdevtools'
au FileType haskell nnoremap <buffer> <F1> :HdevtoolsType<CR>
au FileType haskell nnoremap <buffer> <silent> <F2> :HdevtoolsClear<CR>
" Plugin 'scrooloose/syntastic'

" Non-language specific appearance
Plugin 'flazz/vim-colorschemes'
Plugin 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}
Plugin 'Pychimp/vim-luna'
Plugin 'git@bitbucket.org:kisom/eink.vim.git'
Plugin 'junegunn/seoul256.vim'
Plugin 'gilgigilgil/anderson.vim'
" Type :SCROLL or :COLORS to start. Use arrows to navigate. Hit ESC to stop.
Plugin 'ScrollColors'

" Other
Plugin 'gnupg.vim'
" \di to enter drawit mode; select box in visual mode; \b to make box; \ds to
" leave drawit mode
Plugin 'DrawIt'
" Distraction-free writing in Vim. Recommended here for use with Markdown files:
"
"     https://news.ycombinator.com/item?id=6978563
"
" The same author also wrote this:
"
"     https://github.com/bilalq/lite-dfm
"
" which he uses for coding (it doesn't line up as well but keeps support for
" vsplits uncrippled.
Plugin 'junegunn/goyo.vim'
Plugin 'airblade/vim-gitgutter'

"    " The following are examples of different formats supported.
"    " Keep Plugin commands between vundle#begin/end.
"    " plugin on GitHub repo
"    Plugin 'tpope/vim-fugitive'
"    " plugin from http://vim-scripts.org/vim/scripts.html
"    Plugin 'L9'
"    " Git plugin not hosted on GitHub
"    Plugin 'git://git.wincent.com/command-t.git'
"    " git repos on your local machine (i.e. when working on your own plugin)
"    Plugin 'file:///home/gmarik/path/to/plugin'
"    " The sparkup vim script is in a subdirectory of this repo called vim.
"    " Pass the path to set the runtimepath properly.
"    Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
"    " Avoid a name conflict with L9
"    Plugin 'user/L9', {'name': 'newL9'}

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
" To ignore plugin indent changes, instead use:
"filetype plugin on
"
" Brief help
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Creates the command :Ip which adds a line invoking ipdb and saves.
"
" Unless # is the first thing inserted in insert mode vim interprets it as a
" special character. Escaping it with backslash meant that it was interpreted
" normally, but for some reason the backslashes used showed up in the output.
:command Ip :normal i
    \import ipdb; ipdb.set_trace()
    \ <ESC>a# ------------------------ <ESC>a#
    \<ENTER><ESC>:w<ENTER>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Go
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" https://code.google.com/p/go/source/browse/misc/vim/readme.txt
"
" Some Linux distributions set filetype in /etc/vimrc.
" Clear filetype flags before changing runtimepath to force Vim to reload them.
filetype off
filetype plugin indent off
set runtimepath+=$GOROOT/misc/vim
filetype plugin indent on
syntax on
" Optional: Format on save.
au FileType go au BufWritePre <buffer> Fmt

" A replacement for gofmt that also updates imports.
"
" Requires this package:
"
"    go get code.google.com/p/go.tools/cmd/goimports
"
let g:gofmt_command="goimports"

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Haskell
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" From here: http://vim.wikia.com/wiki/Remove_unwanted_spaces
"
" It would be cool to use a general function to preserve cursor position,
" such as:
"
"     http://technotales.wordpress.com/2010/03/31/preserve-a-vim-function-that-keeps-your-state/
"
" ...but you would have to leave the Z mark in anyway because it's used to
" see if the text has changed.
function StripTrailingWhitespaceHaskell()
  normal mZ
  let l:chars = col("$")
  %s/\s\+$//e
  if (line("'Z") != line(".")) || (l:chars != col("$"))
    echo "Trailing whitespace stripped\n"
  endif
  normal `Z
:endfunction
" autocmd FileType haskell autocmd BufWritePre * :call StripTrailingWhitespaceHaskell()

" A nice way to run https://github.com/jaspervdj/stylish-haskell from Vim.
:command StylishHaskell :normal :%!stylish-haskell<ENTER>

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other Filetype Specific Changes
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Unlike the other syntax files such as 'python.vim', 'text.vim' isn't
" automatically detected so we set it to be detected here.
autocmd BufRead,BufNewFile *.txt set syntax=text

" nvie.com/posts/how-i-boosted-my-vim/
"
" Show tab characters, trailing whitespace and invisible spaces.
" Additionally use the # sign to mark lines that extend off-screen.
set list
set listchars=tab:>-,trail:.,extends:#,nbsp:.
" using #ff5faf for hot pink
hi NonText ctermfg=205 guifg=pink
hi SpecialKey ctermfg=205 guifg=pink
" In some files, like HTML and XML files, tabs are fine and
" showing them is really annoying, you can disable them easily
" using an autocmd declaration:
autocmd filetype html,xml set listchars-=tab:>.

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Univeral appearance
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" This should come after the bundle which installs the colorscheme.
"
" Order also matters for this command because if it comes before the command
" setting the color for tabs to pink, then the native tab color for the
" colorsheme will be overridden.
"
" colorscheme badwolf
" colorscheme eink
" colorscheme moss
" colorscheme mrkn256
" colorscheme zenburn
" colorscheme Tomorrow-Night-Blue
" colorscheme lucius
" colorscheme paintbox
" colorscheme jelleybeans
" colorscheme summerfruit256
" colorscheme paintbox
colorscheme CodeFactoryv3

" Change the color of the 'airblade/vim-gitgutter' column.
" highlight SignColumn ctermbg=black

" " For tomorrow night blue.
" hi ColorColumn ctermbg=darkgrey

set t_Co=256

" " Highlite lines over 79 characters.
" match Error /\%80v.\+/

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Other
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" for escoger
"
" adapted from: https://github.com/garybernhardt/selecta#use-with-vim
"
" Run a given vim command on the results of fuzzy selecting from a given shell
" command. See usage below.
function! EscogerCommand(choice_command, selecta_args, vim_command)
  try
    let selection = system(a:choice_command . " | escoger " . a:selecta_args)
  catch /Vim:Interrupt/
    " Swallow the ^C so that the redraw below happens; otherwise there will be
    " leftovers from selecta on the screen
    redraw!
    return
  endtry
  redraw!
  exec a:vim_command . " " . selection
endfunction
nnoremap <leader>f :call EscogerCommand("find * -name .git -a -type d -prune -o -name bower_components -a -type d -prune -o -name node_modules -a -type d -prune -o -name .cabal-sandbox -prune -o -name dist -prune -o -name .sass-cache -prune -o -name _site -prune -o -name _cache -prune -o -name '*.hi' -prune -o -name '*.o' -prune -o -type f -print", "", ":edit")<cr>
nnoremap <leader>t :call EscogerCommand("find * -name .git -a -type d -prune -o -name bower_components -a -type d -prune -o -name node_modules -a -type d -prune -o -name .cabal-sandbox -prune -o -name dist -prune -o -name .sass-cache -prune -o -name _site -prune -o -name _cache -prune -o -name '*.hi' -prune -o -name '*.o' -prune -o -type f -print", "", ":tabedit")<cr>

" Show line numbers.
set number

set autoindent

set expandtab
set shiftwidth=4
set tabstop=4

" " Don't wrap lines.
" set nowratp

" Don't use swap files.
set noswapfile

set history=1000

" Clear the search buffer when you press ,/
nmap <silent> ,/ :nohlsearch<CR>

" Use vim nav keys to switch tabs.
map  <C-l> :tabn<CR>
map  <C-h> :tabp<CR>

nnoremap ; :
noremap j gj
noremap k gk

" Make searches case-insensative except when you include uppercase characters.
set ignorecase
set smartcase

autocmd BufNewFile,BufRead *.{md,mdwn,mkd,mkdn,mark*} set filetype=markdown

" Backspace was acting weirdly without this (at least with the
" vim_configurable nix package).
"
" http://vimdoc.sourceforge.net/htmldoc/options.html#%27backspace%27
set backspace=2

" Mouse scrolling is unusably buggy in urxvt without this.
set mouse=a

" Don't create a ~/.vim/.netrwhist file.
let g:netrw_dirhistmax=0
