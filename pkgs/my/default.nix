{ callPackage, ... }:

{
  lib = callPackage ./lib {};
  utils = callPackage ./utils {};
}