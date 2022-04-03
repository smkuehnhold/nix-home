{ pkgs, ...}:

{
  typicons = import ./typicons.nix { inherit (pkgs) lib fetchzip; };
}

