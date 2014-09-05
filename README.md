# Intro

A description in code of my [NixOS](http://nixos.org/) setup.

# Screenshot

![screenshot](https://raw.githubusercontent.com/seagreen/vivaine/master/screenshot.png)

For info on the background image try Googling "Makoto Shinkai The Place Promised in Our Early Days".

# Deployment

1. [Install NixOS](http://nixos.org/nixos/manual/#sec-installation).

2. Replace `/etc/nixos/configuration.nix` with `configuration.nix` from this directory. Run `nixos-rebuild switch` from root.

3. Grep this repo for `traveller` (my username) and change it to what's appropriate for your computer. This is a very rough project and `/home/traveller` is hardcoded far more than it needs to be. There are also some hardcoded links to this directory, which is `/home/traveller/vivaine/vivaine` on my computer. Fix those as well.

4. `./link_dotfiles`

5. `./link_bin_files`

6. Load the new `.bashrc` and then run `background-center wallpaper.png`.

7. Move a copy of `.vimrc` and `.vim` to `/root`.

8. `mkdir ~/.screenshots`
