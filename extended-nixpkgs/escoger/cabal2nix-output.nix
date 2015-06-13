{ mkDerivation, base, bytestring, data-default, HUnit, mtl
, parallel, QuickCheck, stdenv, test-framework
, test-framework-hunit, test-framework-quickcheck2, unix, vector
, vector-algorithms, vty
}:
mkDerivation {
  pname = "escoger";
  version = "0.1.0.0";
  sha256 = "";
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
