{ lib, pkgs, config, ... }:
let
  cfg = config.my.home;
in {
  options = with lib; {
    my.home.launcher = mkOption {
      type = types.package;
      default = pkgs.rofi; 
      description = "The terminal emulator used by this desktop";
    }; 
  };

  config = with lib; (mkMerge [
    (mkIf (cfg.launcher == pkgs.rofi) (import ./rofi.nix {inherit lib pkgs config;}))
  ]);
}
