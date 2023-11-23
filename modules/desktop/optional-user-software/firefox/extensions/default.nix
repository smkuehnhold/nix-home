{ pkgs, ... }:

let
  pins = pkgs.callPackage ./pins {};
in with pkgs.nur.repos.rycee.firefox-addons; [
  ublock-origin
  reddit-enhancement-suite
  # sidebery
  # pin sidebery < 5.0.0 because there seems to be some problems in nix
  pins.sidebery
  privacy-badger
  bitwarden
  betterttv
]
