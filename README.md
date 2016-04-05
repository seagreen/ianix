# Intro

A description in code of my [NixOS](http://nixos.org/) setup.

# Screenshot

![screenshot](https://raw.githubusercontent.com/seagreen/vivaine/master/screenshot.png)

For info on the background image try Googling "Makoto Shinkai The Place Promised in Our Early Days".

# Install

(NOTE: This will usually be out of date if I haven't done a fresh install in a while)

1. [Install NixOS](http://nixos.org/nixos/manual/#sec-installation).

2. Grep this repo for `traveller` (my username) and change it to what's appropriate for your computer. This is a very rough project and `/home/traveller` is hardcoded far more than it needs to be. There are also some hardcoded links to this directory, which is `/home/traveller/vivaine/vivaine` on my computer. Fix those as well.

3. (optional) Grep the config files for "cron" and remove any cron jobs you don't want.

4. Setup nixpkgs:

    ```
    cat version.txt
    >> 14.04.414.351aec7 (Baboon)

    git clone git://github.com/NixOS/nixpkgs.git
    cd nixpkgs
    # Replace 351aec7 below with the appropriate value from the output of `cat version.txt`:
    git checkout 351aec7
    ```

5. From root: `nixos-rebuild switch -I nixpkgs=./nixpkgs -I nixos-config=./configuration.nix`

# Post-Install

1. `./link_dotfiles`

2. `./link_bin_files`

3. Download the urxvt colorscheme you'd like to use, update the path to it in ~/.Xdefaults, and reload .Xdefaults (reload instructions are in a comment at the top of the file).

4. Make sure your shell aliases are loaded with `exec zsh`, then run `background-fill wallpaper.png`.

5. `mkdir ~/screenshots`
