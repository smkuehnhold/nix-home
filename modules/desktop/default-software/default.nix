{ lib, config, pkgs, ... }:

with lib;

mkIf config.my.desktop.environment.enable (mkMerge [
  (import ./alacritty {})
  (import ./pavucontrol { inherit (pkgs) pavucontrol; })
])