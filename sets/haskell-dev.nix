{config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [

    # Basics for Haskell dev via cabal-install sandboxes
    #
    # This is the "Direct Install" strategy discussed here:
    #
    #     https://nixos.org/wiki/Haskell#Direct_installation

    haskellPackages.cabalInstall_1_18_0_3 # Earlier versions don't have `cabal sandbox`.
    haskellPlatform.ghc
    haskellPackages.yesodBin

    # Other stuff for Haskell dev via cabal-install sandboxes

    # Required for yesod or one of its dependencies via cabal-install.
    haskellPackages.alex
    # Required for language-javascript-0.5.13 which is needed for yesod.
    haskellPackages.happy
    # Required for yesod via cabal-install.
    haskellPackages.zlib
    # Maybe needed for `nix-shell` style haskell installs.
    #
    # Definitely needed for language-javascript-0.5.13 via cabal-install
    # (which is needed for yesod). Otherwise you get "The program ar is
    # required but it could not be found."
    stdenv

    # Other Haskell

    haskellPackages.hlint
    haskellPackages.random
    haskellPackages.cabal2nix

  ];
}
