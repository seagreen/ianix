{config, pkgs, ... }:

# Use `exec zsh` after nixos-rebuild to load at least some of your zsh changes.
#
# From here:
#
#
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


# You can bypass aliases by using backslash, eg \ls to run the unaliased ls

{
  # If in invoke a command in Zsh that doesn't exist
  # this lists what packages provide it. It also provides
  # a `command-not-found` command to do the same thing.
  #
  # Since I'm not using channels I don't think this is using
  # the right set of packages, but it works well enough.
  programs.command-not-found.enable = true;

  programs.zsh = {
    enable = true;

    promptInit =
      # Changes to the terminal's colorscheme affect how these colors actually appear.

      # http://stackoverflow.com/a/2534676
      # Surround color codes and non-printable characters with %{....%}.

      # NOTE: yellow is showing up as orange.

      # %~ is show whole path, using ~ for $HOME.
      ''
      PS1="%{$fg[cyan]%}[%~]%{$fg[blue]%}%n@%{$fg[blue]%}%m $%{$reset_color%} "
      '';

    interactiveShellInit =
      ''
      autoload -U colors && colors

      fpath=(${pkgs.pass}/share/zsh/site-functions $fpath)
      autoload -U compinit && compinit

      # Set zsh to vi mode.
      bindkey -v

      plugins=(pass)


      ############################################################
      # Nothing from this point on in the file is Zsh specific.
      #
      # It's only here as a convenient way to keep it out of root
      # and nix-shell.
      ############################################################



      # This is required for fasd. It runs once per command executed.
      eval "$(fasd --init auto)"

      arch() {
          firefox -new-window "https://wiki.archlinux.org/index.php?title=Special%3ASearch&search=$1&go=Go" > /dev/null 2>&1
      }

      hgl() {
          hoogle search --count=15 -- $1
      }

      # Using a function because alias doesn't take parameters.
      rungcc() {
          gcc -o temp.out $1
          ./temp.out
          rm temp.out
      }

      # TODO: without this wrapper, attempting to switch to root with `su` doesn't work.
      # Additionally, after attempting to do so, `exit` wouldn't work either.
      # if [ $(whoami) != "root" ]; then
      #     eval "$(gpg-agent --daemon)"
      # fi

      export POSTGRES_PATH="${pkgs.postgresql}";
      export ZLIB_PATH="${pkgs.zlib}";
      '';

    # Using mkForce to totally override the default settings.
    shellAliases = pkgs.lib.mkForce {
      # * NOTE_1
      #
      # The actual zshrc file generated uses single quotes to surround aliases, eg
      #
      #     alias rss='liferea'
      #
      # So you want to use \" here, eg
      #
      #    runghc = "echo \"Alias disabled\""

      ".."   = "cd ..";
      "..."  = "cd ../..";
      "...." = "cd ../../..";

      mirror = "rsync --archive --delete --compress --human-readable";

      background-center = "feh --bg-center";
      background-max    = "feh --bg-max";
      background-fill   = "feh --bg-fill";

      cal = "cal -3 --monday";

      # for escoger
      #
      # about find
      #
      # -a is and
      # -o is or
      #
      # -prune means don't descend into it if it's a dir
      # -print means output
      #
      #
      # cd to a directory below you.
      ecd = "cd $(find * -name .git -a -type d -prune -o -type d -print | escoger)";
      # open file below you in vim
      ev = "nvim $(find * -name .git -a -type d -prune -o -type f -print | escoger)";

      # Print absolute path to file.
      full = "readlink -f";

      ci = "cabal install --only-dependencies --enable-tests";
      crebuild = "cabal build --ghc-options=\"-fforce-recomp\"";
      crm = "cabal sandbox -- hc-pkg unregister";
      ccheck = "cabal build --ghc-options=\"-fforce-recomp -Wall\"";
      ghc-sandbox = "ghc -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d";
      ghci-sandbox = "ghci -no-user-package-db -package-db .cabal-sandbox/*-packages.conf.d";
      # NOTE: used to have an asterisk instead of the x86_64... part, but it didn't seem to actually work
      runhaskell-sandbox = "runhaskell -no-user-package-db -package-db=.cabal-sandbox/x86_64-linux-ghc-7.10.1-packages.conf.d";

      # The first git message is special (I believe because it has no parent and
      # so is harder to change) so start project with an empty commit.
      #
      # Idea from here: http://stackoverflow.com/a/22233092
      #
      # * See NOTE_1 for why \" is used.
      gitinit = "git init; git commit --allow-empty -m \"Create repo.\"";

      # Nix's gnupg makes a gpg2 executable.
      gpg = "gpg2";

      linth = "hlint --hint=/home/traveller/.hlint.hs";

      lock = "i3lock"; # "systemctl suspend & i3lock";

      # -A flag shows dotfiles other than . and ..
      #
      # Using   color   to  distinguish  file  types  is  disabled  both  by  default  and  with
      # --color=never.  With --color=auto, ls emits color codes only  when  standard  output  is
      # connected  to  a  terminal.  The LS_COLORS environment variable can change the settings.
      # Use the dircolors command to set it.
      #
      # LC_COLLATE=C shows dotfiles first, instead of mixed through the output.
      ls = "LC_COLLATE=C ls -A --color=auto";

      tree = "tree -a";

      lorem = "xclip ~/config/extended-config/utilities/lorem_ipsum.txt";

      # Make a nice password.
      #
      # --symbols : include symbols and use at least one
      # first number : length of password
      # second number : number of passwords to generate
      mkpass = "pwgen --no-capitalize --symbols 14 1";

      # grep -I ignores binary files.
      mygrep = "grep -ri --binary-files=without-match";

      nim-search = "nix-env -qaP --description | grep -i";

      pingit = "ping www.google.com";

      voldown = "amixer set Master unmute 8%-";
      volup   = "amixer set Master unmute 8%+";

      # Run rot13 without args and then enter your text. From here:
      # http://www.commandlinefu.com/commands/view/1792/rot13-using-the-tr-command
      #
      # rot13 = "tr '[A-Za-z]' '[N-ZA-Mn-za-m]'";

      unixtime = "date +%s";

      # No easy way to view TAI on linux, can do it here:
      # https://www.timeanddate.com/worldclock/other/tai

      # Custom fasd command to open a file with vim.
      v = "f -e nvim";

      # When given multiple filepaths as arguments to vim, open each
      # in a separate tab.
      vi = "nvim";
      vim = "nvim";
      nvim = "nvim -p";
      vimdiff = "\\nvim -d"; # Because `nvim -dp` just opens the two files as tabs without diffing.
                             # NOTE: The double backslash escapces to a single backslash, which
                             # bypasses the previous alias of `nvim=nvim -p`.

      yt = "youtube-dl --extract-audio --audio-format vorbis";

      srebuild = "stack clean; stack build";
    };
  };
}
