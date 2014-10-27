{config, pkgs, ... }:


{
  # Basics for Haskell dev via cabal-install sandboxes
  #
  # This is the "Direct Install" strategy discussed here:
  #
  #     https://nixos.org/wiki/Haskell#Direct_installation
  environment.systemPackages = with pkgs; [

    (haskellPackages_ghc783.ghcWithPackages (self : [
      haskellPackages.zlib
    ]))

    haskellPackages.cabalInstall_1_18_0_3 # Earlier versions don't have `cabal sandbox`.


    haskellPackages.yesodBin

    haskellPackages.alex
    haskellPackages.happy
    # Maybe needed for `nix-shell` style haskell installs as well.
    stdenv

  ];
}
