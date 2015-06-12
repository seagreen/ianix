{ pkgs ? (import <nixpkgs> {}), haskellPackages ? (import <nixpkgs> {}).haskellPackages_ghc783 }:

let
  inherit (haskellPackages) data-default HUnit mtl parallel QuickCheck
                        test-framework test-framework-hunit test-framework-quickcheck2
                        vector vector-algorithms vty;

  inherit (pkgs) stdenv fetchFromGitHub;

  rv = "b6b11c51846a9283ef4ee7c839b99ded9f6c3bc8";

in haskellPackages.mkDerivation {
  pname = "escoger";
  version = "0.1.0.0-${rv}";
  src = fetchFromGitHub {
    owner = "tstat";
    repo = "escoger";
    rev = rv;
    sha256 = "0n6mvg5cm50ym20bz74b7q1afkljp0fc9pxhqk0ai82a71xxbxy3";
  };
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    data-default mtl parallel vector vector-algorithms vty
  ];
  testDepends = [
    data-default HUnit mtl parallel QuickCheck test-framework
    test-framework-hunit test-framework-quickcheck2 vector vector-algorithms
    vty
  ];
  license = stdenv.lib.licenses.mit;
}
