{ config, pkgs, ... }:

# Basics for Haskell dev via cabal-install sandboxes.
#
# This is the "Direct Install" strategy discussed here:
#
#     https://nixos.org/wiki/Haskell#Direct_installation
{
  environment.systemPackages = with pkgs; [

    # https://hackage.haskell.org/package/Cabal
    # haskellPackages.cabalInstall
    haskellPackages.cabal-install
    # supposed to fix ghc mod problem
    # haskellPackages.cabalInstall_1_20_0_6

    (haskell.packages.ghc7101.ghcWithPackages (self : [
      haskellPackages.zlib
    ]))

    gcc
    binutils # For the ar executable.
    haskellPackages.alex
    haskellPackages.happy

    # For `yesod devel`.
    haskellPackages.yesod-bin

    # Tooling

    # BROKEN
    # haskellPackages.ghc-mod
    haskellPackages.hdevtools
    haskellPackages.hlint
    haskellPackages.hoogle
    haskellPackages.stylish-haskell
  ];
}
