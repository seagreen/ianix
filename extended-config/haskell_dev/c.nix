{config, pkgs, ... }:

# Basics for Haskell dev via cabal-install sandboxes
#
# This is the "Direct Install" strategy discussed here:
#
#     https://nixos.org/wiki/Haskell#Direct_installation
{
  environment.systemPackages = with pkgs; [

    (haskellPackages_ghc783.ghcWithPackages (self : [
      haskellPackages.zlib
    ]))

    # Earlier versions don't have `cabal sandbox`.
    haskellPackages.cabalInstall_1_18_0_3

    stdenv

    haskellPackages.alex
    haskellPackages.happy

    # For `yesod devel`.
    haskellPackages.yesodBin

  ];
}
