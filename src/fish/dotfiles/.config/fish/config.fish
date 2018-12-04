# $EDITOR is set by nixos config
set VISUAL $EDITOR

alias nix-fish "nix-shell --command fish"

alias g "git"

alias sb "stack build --ghc-options=-O0"

# currently need to name the specific test suite for rerunning to work
alias sbt "stack build --ghc-options=-O0 --test --test-arguments '--rerun --failure-report=TESTREPORT --rerun-all-on-success'"

alias sclean "stack clean; stack build --ghc-options=-O0 --ghc-options=-Werror --file-watch"

alias mirror "rsync --archive --delete --compress --human-readable"

alias cal "cal -3 --monday"

alias full "readlink -f"

# The first git message is special (I believe because it has no parent and
# so is harder to change) so start project with an empty commit.
#
# Idea from here: http://stackoverflow.com/a/22233092
#
# * See NOTE_1 for why \" is used.
alias gitinit "git init; git commit --allow-empty -m 'Create repo.'"

# -A flag shows dotfiles other than . and ..
#
# Using   color   to  distinguish  file  types  is  disabled  both  by  default  and  with
# --color=never.  With --color=auto, ls emits color codes only  when  standard  output  is
# connected  to  a  terminal.  The LS_COLORS environment variable can change the settings.
# Use the dircolors command to set it.
#
# LC_COLLATE=C shows dotfiles first, instead of mixed through the output.
# alias ls "LC_COLLATE=C ls -A --color=auto"

alias tree "tree -a"

alias lorem "xclip ~/config/extended-config/utilities/lorem_ipsum.txt"

# Make a nice password.
#
# --symbols : (not currently used)
#             Include symbols and use at least one.
# first number : length of password
# second number : number of passwords to generate
alias mkpass "pwgen --no-capitalize 10 1"

alias pingit "ping www.google.com"

alias voldown "amixer set Master unmute 8%-"
alias volup   "amixer set Master unmute 8%+"

# Run rot13 without args and then enter your text. From here:
# http://www.commandlinefu.com/commands/view/1792/rot13-using-the-tr-command
#
# rot13 = "tr '[A-Za-z]' '[N-ZA-Mn-za-m]'";

alias unixtime "date +%s"

# No easy way to view TAI on linux, can do it here:
# https://www.timeanddate.com/worldclock/other/tai

# Custom fasd command to open a file with vim.
alias v "f -e nvim"

abbr fuzzle "ls -lah"

# When given multiple filepaths as arguments to vim, open each
# in a separate tab.
alias vi "nvim"
alias vim "nvim"
alias nvim "nvim -p"
alias vimdiff "command nvim -d" # Because `nvim -dp` just opens the two files as tabs without diffing.
                                # NOTE: The `command` bypasses the previous alias of `alias nvim "nvim -p"`.

alias yt "youtube-dl --extract-audio --audio-format vorbis"

# Modified from the prompt here (which I think is the default):
#
# https://github.com/fish-shell/fish-shell/blob/3f11d90744ef1ab1b32f394d50eb4b911aaf50f3/share/functions/fish_prompt.fish
function fish_prompt --description "Write out the prompt"
  # Just calculate this once, to save a few cycles when displaying the prompt
  if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  set -l color_cwd
  set -l suffix
  switch $USER
  case root toor
    if set -q fish_color_cwd_root
      set color_cwd $fish_color_cwd_root
    else
      set color_cwd $fish_color_cwd
    end
    set suffix '#'
  case '*'
    set color_cwd $fish_color_cwd
    set suffix '>'
  end

  if test -n "$IN_NIX_SHELL"
    set nix_shell " nix"
  end

  # Ian: changed (prompt_pwd) to (tilde_pwd)
  echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' (set_color $color_cwd) (tilde_pwd) (set_color normal) "$nix_shell" "$suffix "
end

# A pwd command that:
#
# + Doesn't abbreviate parent directory names (like prompt_pwd).
#
# + Shows $HOME as `~` (unlike pwd).
function tilde_pwd
  pwd | sed -e "s|^$HOME|~|"
end

# Remove startup message.
#
# Defining a fish_greeting function instead of unsetting $fish_greeting
# because the latter's a Universal Variable and changes to it would
# persist even if the setting was removed here.
function fish_greeting
end

# fasd for z
#
# Can't just use FZF here because it doesn't search by frecency.
#
# Modified from:
# https://jurriaan.ninja/2014/12/21/fish-shell-and-fasd.html
function __record_using_fasd --on-event fish_preexec
  fasd --proc (fasd --sanitize "$argv") > "/dev/null" 2>&1
end

function z
  cd (fasd -d -e 'printf %s' "$argv")
end

# FZF Integration for ctrl+r:
#
# 1. Installed fzf binary and symlinked it to ~/.local/bin.
#
# 2. Placed fzf/shell/key-bindings.fish at ~/.config/fish/functions/fzf_key_bindings
#
# 3. Modified the top level function there to match the new filename.
#
# 4. Sourced it by defining fish_user_key_bindings here as required by: https://fishshell.com/docs/current/commands.html#bind
function fish_user_key_bindings
  fzf_key_bindings
end
