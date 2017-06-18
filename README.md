# Intro

A description in code of my [NixOS](http://nixos.org/) setup.

# Screenshot

![screenshot](https://raw.githubusercontent.com/seagreen/ianix/master/screenshot.png)

For info on the background image try Googling "Makoto Shinkai The Place Promised in Our Early Days".

# Install

(NOTE: This will usually be out of date if I haven't done a fresh install in a while)

1. [Install NixOS](http://nixos.org/nixos/manual/#sec-installation).

2. Download this repo and symlink `~/config` to it.

3. Grep this repo for `traveller` (my username) and change it to what's appropriate for your computer. This is a very rough project and `/home/traveller` is hardcoded far more than it needs to be.

4. (optional) Grep the config files for "cron" and remove any cron jobs you don't want.

5. Setup nixpkgs:

    ```
    cat version.txt
    >> 14.04.414.351aec7 (Baboon)

    git clone git://github.com/NixOS/nixpkgs.git
    cd nixpkgs
    # Replace 351aec7 below with the appropriate value from the output of `cat version.txt`:
    git checkout 351aec7
    ```

6. From `/etc/nixos/configuration.nix` import this repo's `./shared.nix`.

Alternately if you want to add your configuration to version control, make a folder for your machine in this repo following the example of `./desktop`. Add your `configuration.nix` and `hardware-configuration.nix` to it, modify your configuration import this repo's `./shared.nix`, then change `/etc/nixos/configuration.nix` to import your machine-specific config, eg:
```nix
{
  imports = [ /home/traveller/config/desktop/configuration.nix ];
}
```

7. From root: `nixos-rebuild switch -I nixpkgs=<path_to_nixpkgs>`

# Post-Install

1. `./link_dotfiles`

2. `./link_bin_files`

3. Download the urxvt colorscheme you'd like to use, update the path to it in ~/.Xdefaults, and reload .Xdefaults (reload instructions are in a comment at the top of the file).

4. Make sure your shell aliases are loaded with `exec zsh`, then run `background-fill wallpaper.png`.

5. `mkdir ~/screenshots`
