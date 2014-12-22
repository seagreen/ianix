{ config, pkgs, ... }:

# Basics for Haskell dev via cabal-install sandboxes
#
# This is the "Direct Install" strategy discussed here:
#
#     https://nixos.org/wiki/Haskell#Direct_installation
{
  environment.systemPackages = with pkgs; [

    haskellPackages.cabalInstall

    (haskellPackages_ghc783.ghcWithPackages (self : [
      haskellPackages.zlib
    ]))

    gcc
    binutils # For the ar executable.
    haskellPackages.alex
    haskellPackages.happy

    # For `yesod devel`.
    haskellPackages.yesodBin

  ];
}
