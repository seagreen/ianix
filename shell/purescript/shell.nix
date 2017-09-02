let
  _pkgs = import <nixpkgs> {};
in
{ pkgs ? import (_pkgs.fetchFromGitHub
  { owner = "NixOS";
    repo = "nixpkgs-channels";
    # This is just the latest unstable `nixpkgs`, there's nothing special about it:
    rev = "799435b";
    sha256 = "1x61hpkagydrf05y0sa1ynmi8z3sm2377f4f6yiqlj9yvkg57jv3";
  }) {}
}:

pkgs.stdenv.mkDerivation {
  name = "none";
  buildInputs = [
    _pkgs.psc-package

    # Untracked (but not unexpected) dep of psc-package.
    _pkgs.haskellPackages.purescript

    # Untracked dep of psc-package.
    #
    # Without it commands in the repl fail:
    # ```
    # > 2
    # Couldn't find node.js
    # ```
    _pkgs.nodejs
  ];
}