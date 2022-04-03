{ config, pkgs, lib, ... }:
let
  cfg = config.my.home;
in {
  options = with lib; {
    my.home.statusBar = mkOption {
      type = types.package;
      default = pkgs.polybar;
      description = "The status bar used by the desktop";
    };
  };

  config = with lib; (mkMerge [
    (mkIf (cfg.statusBar == pkgs.polybar) (import ./polybar { inherit pkgs; }))
  ]);
}
