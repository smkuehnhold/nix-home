{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.my.desktop.environment;
  isEnabled = cfg.enable && cfg.includesOptionalUserSoftware;
in mkIf isEnabled (mkMerge [
  (import ./discord { inherit lib pkgs; })
  (import ./firefox { inherit pkgs; })
  (import ./free-cad { inherit pkgs; })
  (import ./gimp { inherit pkgs; })
  (import ./inkscape { inherit pkgs; })
  (import ./kdenlive { inherit pkgs; })
  (import ./mpv {})
  (import ./simple-scan { inherit pkgs; })
  ({
    home.packages = with pkgs; [ 
      evince
      logseq
    ];
  })
])
