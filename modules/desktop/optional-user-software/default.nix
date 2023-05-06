{ lib, config, pkgs, ... }:

with lib;

let
  cfg = config.my.desktop.environment;
  isEnabled = cfg.enable && cfg.includesOptionalUserSoftware;
in mkIf isEnabled (mkMerge [
  (import ./discord { inherit lib pkgs; })
  (import ./firefox { inherit pkgs; })
  (import ./kdenlive { inherit pkgs; })
  (import ./mpv {})
  (import ./simple-scan { inherit pkgs; })
])
