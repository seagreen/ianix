set EDITOR vim
set VISUAL $EDITOR

# Modified from the prompt here (which I think is the default):

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

  # Ian: changed (prompt_pwd) to (tilde_pwd)
  echo -n -s "$USER" @ "$__fish_prompt_hostname" ' ' (set_color $color_cwd) (tilde_pwd) (set_color normal) "$suffix "
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
# https://jurriaan.ninja/2014/12/21/fish-shell-and-fasd.html
#
# Can't just use FZF here because it doesn't search by frecency.
function -e fish_preexec _run_fasd
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
