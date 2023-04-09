{ lib, config, pkgs, ... }: 

with lib;

let
  cfg = config.my.desktop.environment;
  isEnabled = cfg.enable && cfg.base == "bspwm+sxhkd";
in mkIf isEnabled (mkMerge [
  (import ./autorandr { inherit pkgs; })
  (import ./bspwm { inherit pkgs; })
  (import ./polybar { inherit pkgs; })
  (import ./rofi { inherit lib config pkgs; })
  (import ./sxhkd { inherit lib config pkgs; })
  (import ./wired {})
])