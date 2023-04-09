{ pkgs, ... }:

with pkgs.nur.repos.rycee.firefox-addons; [
  ublock-origin
  reddit-enhancement-suite
  sidebery
  privacy-badger
  bitwarden
#  betterttv
]