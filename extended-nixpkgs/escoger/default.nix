{ mkDerivation, base, bytestring, data-default, HUnit, mtl
, parallel, QuickCheck, stdenv, test-framework
, test-framework-hunit, test-framework-quickcheck2, unix, vector
, vector-algorithms, vty
,fetchFromGitHub }:
mkDerivation {
  jailbreak = true;
  pname = "escoger";
  version = "0.1.0.0";
  src = fetchFromGitHub {
    owner = "tstat";
    repo = "escoger";
    rev = "b6b11c51846a9283ef4ee7c839b99ded9f6c3bc8";
    sha256 = "0n6mvg5cm50ym20bz74b7q1afkljp0fc9pxhqk0ai82a71xxbxy3";
  };
  isLibrary = false;
  isExecutable = true;
  buildDepends = [
    base bytestring data-default mtl parallel unix vector
    vector-algorithms vty
  ];
  testDepends = [
    base bytestring data-default HUnit mtl parallel QuickCheck
    test-framework test-framework-hunit test-framework-quickcheck2 unix
    vector vector-algorithms vty
  ];
  license = stdenv.lib.licenses.mit;
}
