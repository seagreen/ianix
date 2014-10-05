"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Setup Vundle
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" To install new bundles (1) add the bundle below (2) restart vim, and (3) run:
" :BundleInstall
"
" Use :BundleInstall! to update.
"
" Use :BundleClean to remove unused bundles.

set nocompatible               " be iMproved
filetype off                   " required!

set rtp+=~/.vim/bundle/vundle/
call vundle#rc()

" let Vundle manage Vundle
" required!
Bundle 'gmarik/vundle'

filetype plugin indent on     " required!
"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

""" Syntax Examples
"
""" original repos on github
" Bundle 'tpope/vim-fugitive'
""" vim-scripts repos (this refers to the 'vim-scripts' user on GitHub.)
" Bundle 'FuzzyFinder'
""" non github repos
" bundle 'git://git.wincent.com/command-t.git'
""" git repos on your local machine (ie. when working on your own plugin)
" bundle 'file:///users/gmarik/path/to/plugin'

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Python
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

Bundle 'davidhalter/jedi-vim'
Bundle 'ervandew/supertab'
" Tab scrolls down lists, not up
let g:SuperTabDefaultCompletionType = "<c-n>"

" Command to quickly print pretty JSON.
:command Jd :normal i
    \import json;
    \ print json.dumps(<OBJ>, sort_keys=True, indent=2, separators=(',', ': '))
    \<ENTER><ESC>:w<ENTER>

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

Bundle 'flazz/vim-colorschemes'

Bundle 'chriskempson/tomorrow-theme', {'rtp': 'vim/'}

Bundle 'Pychimp/vim-luna'

Bundle 'git@bitbucket.org:kisom/eink.vim.git'

" Type :SCROLL or :COLORS to start. Use arrows to navigate. Hit ESC to stop.
Bundle 'ScrollColors'

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
colorscheme luna

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

" Show line numbers.
" set number

Bundle 'gnupg.vim'

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
Bundle "junegunn/goyo.vim"

Bundle 'airblade/vim-gitgutter'

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
