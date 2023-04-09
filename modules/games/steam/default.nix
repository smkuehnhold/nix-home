{ lib, config, pkgs, ... }:

with lib;

mkIf (builtins.elem "steam" config.my.games.suites) {
  home.packages = with pkgs; [ steam ];
}