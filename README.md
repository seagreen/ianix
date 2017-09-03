# Intro

A description in code of my [NixOS](http://nixos.org/) setup.

# Screenshot

![screenshot](https://raw.githubusercontent.com/seagreen/ianix/master/screenshot.png)

For info on the background image try Googling "Makoto Shinkai The Place Promised in Our Early Days".

# Install

(NOTE: This will usually be out of date if I haven't done a fresh install in a while)

1. [Install NixOS](http://nixos.org/nixos/manual/#sec-installation).

2. Download this repo.

3. Grep this repo for `traveller` (my username) and change it to what's appropriate for your computer. This is a very rough project and `/home/traveller` is hardcoded far more than it needs to be. You may also want to place this repo at `~/config` or have a symlink from there pointed at this repo, some code may assume that's where the repo is located.

4. (optional) Grep the config files for "cron" and remove any cron jobs you don't want.

5. Install `stow`.

6. `./link_dotfiles`

7. `./link_bin`

8. Setup nixpkgs:

    ```
    cat version.txt
    >> 14.04.414.351aec7 (Baboon)

    git clone git://github.com/NixOS/nixpkgs.git
    cd nixpkgs
    # Replace 351aec7 below with the appropriate value from the output of `cat version.txt`:
    git checkout 351aec7
    ```

9. From `/etc/nixos/configuration.nix` import this repo's `./shared.nix`.

    Alternately if you want to add your machine-specific configuration to this repo, make a folder for your machine in this repo following the example of `./desktop`. Add your `configuration.nix` and `hardware-configuration.nix` to it. Modify your configuration import this repo's `./shared.nix`, then change `/etc/nixos/configuration.nix` to import your machine-specific config, eg:
    ```nix
    {
      imports = [ /home/traveller/config/machine/desktop/configuration.nix ];
    }
    ```

10. From root: `nixos-rebuild switch -I nixpkgs=<path_to_nixpkgs>`

# Post-Install

1. (optional) Download the urxvt colorscheme you'd like to use, update the path to it in ~/.Xdefaults, and reload .Xdefaults (reload instructions are in a comment at the top of the file).

2. Make sure your shell aliases are loaded with `exec zsh`, then run `background-fill wallpaper.png`.

3. `mkdir ~/screenshots`
