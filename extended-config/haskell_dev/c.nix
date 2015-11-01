{ config, pkgs, ... }:

# Basics for Haskell dev via cabal-install sandboxes.
#
# This is the "Direct Install" strategy discussed here:
#
#     https://nixos.org/wiki/Haskell#Direct_installation
{
  environment.systemPackages = with pkgs; [

    haskellPackages.cabal-install

    (haskell.packages.ghc7102.ghcWithPackages (self : [
    ]))

    gcc
    binutils # For the ar executable.
    haskellPackages.alex
    haskellPackages.happy
    haskellPackages.zlib

    # For `yesod devel`.
    haskellPackages.yesod-bin

    # Tooling

    haskellPackages.ghc-mod
    haskellPackages.hdevtools
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.stylish-haskell
  ];
}
