# Intro

A description in code of my [NixOS](http://nixos.org/) setup.

# Screenshot

![screenshot](https://raw.githubusercontent.com/seagreen/vivaine/master/screenshot.png)

For info on the background image try Googling "Makoto Shinkai The Place Promised in Our Early Days".

# Deployment

1. [Install NixOS](http://nixos.org/nixos/manual/#sec-installation).

2. Replace `/etc/nixos/configuration.nix` with `configuration.nix` from this directory. Run `nixos-rebuild switch` from root.

3. Create symlinks in `~` to the files in `dotfiles`.

4. Create a symlink in `~` to the `bin` directory in this repo.

5. Grep this repo for `traveller` (my username) and change it to what's appropriate for your computer. Also change the directory where screenshots are stored in `bin/screenshot` and `bin/screenshot-select`. This is a very rough project and `/home/traveller` is hardcoded far more than it needs to be.

6. Move a copy of `.vimrc` and `.vim` to `/root`.
