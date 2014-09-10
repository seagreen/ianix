# Intro

A description in code of my [NixOS](http://nixos.org/) setup.

# Screenshot

![screenshot](https://raw.githubusercontent.com/seagreen/vivaine/master/screenshot.png)

For info on the background image try Googling "Makoto Shinkai The Place Promised in Our Early Days".

# Deployment

1. [Install NixOS](http://nixos.org/nixos/manual/#sec-installation).

2. Replace `/etc/nixos/configuration.nix` with `configuration.nix` from this directory.

3. Switch to the unstable branch. This is optional but it's what I've done since I want cutting edge versions of packages for development.

    ```
    # Both commands from root:

    nix-channel --add http://nixos.org/channels/nixos-unstable nixos
    nix-channel --update nixos
    ```

4. From root: `nixos-rebuild switch`

5. Grep this repo for `traveller` (my username) and change it to what's appropriate for your computer. This is a very rough project and `/home/traveller` is hardcoded far more than it needs to be. There are also some hardcoded links to this directory, which is `/home/traveller/vivaine/vivaine` on my computer. Fix those as well.

6. `./link_dotfiles`

7. `./link_bin_files`

8. Load the new `.bashrc` and then run `background-center wallpaper.png`.

8. Move a copy of `.vimrc` and `.vim` to `/root`.

10. `mkdir ~/.screenshots`

# Using Pinned Dependencies

`nixos-rebuild switch` will install the latest versions of the packages listed in `configuration.nix`. To get an install with my exact versions of each package follow the "Deployment" commands, but replace `nixos-rebuild switch` in step two with the commands below.

This may be very slow, so I don't recommend doing it unless you need to.

(commands based on the ones here: https://nixos.org/nixos/community.html)

```
cat version.txt
>> 14.04.414.351aec7 (Baboon)

git clone git://github.com/NixOS/nixpkgs.git
cd nixpkgs
# Replace 351aec7 below with the appropriate value from the output of `cat version.txt`:
git checkout 351aec7

# From root:
nixos-rebuild switch -I nixpkgs=/path/to/my/nixpkgs
```
