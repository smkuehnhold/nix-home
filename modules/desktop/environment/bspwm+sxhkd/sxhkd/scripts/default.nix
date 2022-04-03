{ pkgs, ... }:

with pkgs;
{
  numbers = callPackage ./numbers {};
}

