{ pkgs, fetchurl, lib, stdenv } @args:

{
  sidebery = (import ./sidebery.nix { inherit pkgs lib; });
}