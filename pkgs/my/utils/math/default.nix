{ callPackage, ... }:

{
  ceil = callPackage ./ceil.nix {};
  floor = callPackage ./floor.nix {};
  lowerToNextMultiple = callPackage ./lower-to-next-multiple.nix {};    
  raiseToNextMultiple = callPackage ./raise-to-next-multiple.nix {};
  validateDecimal = callPackage ./validate-decimal.nix {};
  validateWholeDecimal = callPackage ./validate-whole-decimal.nix {};
}
