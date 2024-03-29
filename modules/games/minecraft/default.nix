{ lib, config, pkgs, ... }:

with lib;

mkIf (builtins.elem "minecraft" config.my.games.suites) {
  home.packages = with pkgs; [ prismlauncher ];
}