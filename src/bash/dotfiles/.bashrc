echo executed ians .bashrc

# If we're not an interactive shell, do nothing.
#
# See: http://superuser.com/a/448930
[ -z "$PS1" ] && return

# Source global definitions.
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

# Some of the below was adapted from LoKe and tetra's ~/.bashrc.


###############################################################################
# For Programs
###############################################################################

# http://stackoverflow.com/questions/7131670/make-bash-alias-that-takes-parameter
#
# Comment:
#
# If you are changing an alias to a function, sourceing your .bashrc will add
# the function but it won't unalias the old alias. Since aliases are higher
# precedent than functions, it will try to use the alias. You need to either
# close and reopen your shell, or else call unalias <name>. Perhaps I'll save
# someone the 5 minutes I just wasted.
#
# ---
#
# Comment:
#
# One time-saving trick I learned at Sun is to just do an exec bash: It will
# start a new shell, giving you a clean read of your configs, just as if you
# closed and reopened, but keeping that session's environment variable settings
# too.

# Using a function because alias doesn't take parameters.
rungcc() {
    gcc -o temp.out $1
    ./temp.out
    rm temp.out
}

# for escoger
#
# cd to a directory below you.
alias ecd='cd $(find * -name .git -a -type d -prune -o -type d -print | escoger)'
# Customized cd to my code folders.
alias ecode='cd $(find ~/code -maxdepth 2 -type d | escoger)'

# This is required for fasd. It runs once per command executed.
eval "$(fasd --init auto)"
# Custom fasd command to open a file with vim.
alias v='f -e vim'

# Nix's gnupg makes a gpg2 executable.
alias gpg='gpg2'

# For vim-gnupg specifically, but gpg always wants this, see:
# https://www.gnupg.org/documentation/manuals/gnupg-devel/Invoking-GPG_002dAGENT.html
GPG_TTY=$(tty)
export GPG_TTY

# TODO: without this wrapper, attempting to switch to root with `su` doesn't work.
# Additionally, after attempting to do so, `exit` wouldn't work either.
if [ $(whoami) != "root" ]; then
    eval "$(gpg-agent --daemon)"
fi

# The first git message is special (I believe because it has no parent and
# so is harder to change) so start project with an empty commit.
#
# Idea from here: http://stackoverflow.com/a/22233092
alias gitinit='git init; git commit --allow-empty -m "Create repo."'

alias runghc='echo "Alias disabled in ~/.bashrc"'
alias runhaskell='runhaskell -Wall'
# Recursive Haskell Linter
alias rhlint='find . -name "*.hs" | xargs hlint'

alias nim-search='nix-env -qaP --description | grep -i'
export NIXPKGS_ALLOW_UNFREE=1

# For pass command completion
#
# TODO: how to avoid hardcoding this?
source /nix/store/xzi9k0an1015c055gh8jirdpx7m0rpy0-password-store-1.4.2/etc/bash_completion.d/password-store

# Make a nice password.
#
# --symbols : include symbols and use at least one
# first number : length of password
# second number : number of passwords to generate
alias mkpass='pwgen --no-capitalize --symbols 14 1'

# Otherwise backspace wasn't working in vim within urxvt.
#
# Note that this happened whether `set backspace=2` was set in vim or not.
# This is different than the xterm bug -- for that setting backspace=2 in
# .vimrc alone fixed it.
stty erase ^?

# -p[N]    Open N tab pages.  When N is omitted, open one tab page for each file.
alias vim='vim -p'

alias yt='youtube-dl --extract-audio --audio-format vorbis'


###############################################################################
# General
###############################################################################


# Don't store commands repeated by arrowing up.
export HISTCONTROL=ignoredups

# Set bash to vi mode.
set -o vi

export EDITOR=vim


###############################################################################
# Go
###############################################################################


# http://golang.org/doc/install

export GOPATH=/home/traveller/code/go
export PATH=$GOPATH/bin:$PATH # Add programs we compile to $PATH.

export GOROOT=/nix/store/mrnlp871pmhlp9m5almm52faq3v8s3q5-go-1.2.1/share/go
export PATH=$PATH:$GOROOT/bin


###############################################################################
# Python specific
###############################################################################


# Don't create .pyc files.
export PYTHONDONTWRITEBYTECODE=1


###############################################################################
# Other Aliases
###############################################################################

# You can bypass aliases by using backslash, eg \ls to run the unaliased ls

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

alias background-center='feh --bg-center'
alias background-max='feh --bg-max'
alias background-fill='feh --bg-fill'

alias cal='cal -3'

# Print absolute path to file.
alias full='readlink -f'

alias lock='i3lock'

# -A flag shows dotfiles other than . and ..
#
# Using   color   to  distinguish  file  types  is  disabled  both  by  default  and  with
# --color=never.  With --color=auto, ls emits color codes only  when  standard  output  is
# connected  to  a  terminal.  The LS_COLORS environment variable can change the settings.
# Use the dircolors command to set it.
#
# LC_COLLATE=C shows dotfiles first, instead of mixed through the output.
alias ls='LC_COLLATE=C ls -A --color=auto'

# grep -I ignores binary files.
alias mygrep='grep -ri --binary-files=without-match --exclude-dir="active" --exclude-dir="old_code"'


alias pingit='ping www.google.com'

alias version='cat /etc/issue'

alias voldown='amixer set Master unmute 8%-'
alias volup='amixer set Master unmute 8%+'

# Run rot13 without args and then enter your text. From here:
# http://www.commandlinefu.com/commands/view/1792/rot13-using-the-tr-command
#
alias rot13="tr '[A-Za-z]' '[N-ZA-Mn-za-m]'"

# Recursive General Linter. Print names of files with trailing whitespace.
#
# Discover trailing spaces:
# http://stackoverflow.com/questions/11210126/bash-find-files-with-trailing-spaces-at-the-end-of-the-lines
#
# Skip binary files:
# http://stackoverflow.com/questions/4767396/linux-command-how-to-find-only-text-files
#
# This is a good example of how horrible UNIX commands can get.
alias rglint='find . -type f | xargs grep -EIl "*" | xargs grep -El ".* +$"'

alias rss='liferea'

alias serve='python -m SimpleHTTPServer'

alias unixtime='date +%s'

###############################################################################
# Prompts and Colors
###############################################################################


# These names are close to true for the Tomorrow Night Bright theme, but not
# quite right. For example, $WHITE shows up as dark gray.
NORMAL='\[\033[00m\]'
BLACK='\[\033[0;30m\]'
RED='\[\033[0;31m\]'
GREEN='\[\033[0;32m\]'
BROWN='\[\033[0;33m\]'
BLUE='\[\033[0;34m\]'
PURPLE='\[\033[0;35m\]'
CYAN='\[\033[0;36m\]'
LGRAY='\[\033[0;37m\]'
DGRAY='\[\033[1;30m\]'
LRED='\[\033[1;31m\]'
LGREEN='\[\033[1;32m\]'
YELLOW='\[\033[1;33m\]'
LBLUE='\[\033[1;34m\]'
PINK='\[\033[1;35m\]'
LCYAN='\[\033[1;36m\]'
WHITE='\[\033[1;37m\]'


# Color tester:
#
# PS1="${NORMAL}NORMAL${BLACK}BLACK${RED}RED${GREEN}GREEN${BROWN}BROWN${BLUE}BLUE${PURPLE}PURPLE${CYAN}CYAN${LGRAY}LGRAY${DGRAY}DGRAY${LRED}LRED${LGREEN}LGREEN${YELLOW}YELLOW${LBLUE}LBLUE${PINK}PINK${LCYAN}LCYAN${WHITE}WHITE"


# The PS1 variable controls the terminal prompt.
#
# To see the default PS1, comment out PS1 below, start a new terminal, and run:
#
#     echo $PS1
#
# The current default is:
#
#     \n\[\033[1;32m\][\u@\h:\w]\$\[\033[0m\]


# See here for prompt variables:
#
#     http://www.gnu.org/software/bash/manual/bashref.html#Printing-a-Prompt
#
PS1="${LCYAN}[\w] \u@\h \$${NORMAL} "
