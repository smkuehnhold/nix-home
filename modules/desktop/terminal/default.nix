{ lib, pkgs, config, ... }:
let
  cfg = config.my.home;
in {
  options = with lib; {
    my.home.terminal = mkOption {
      type = types.package;
      default = pkgs.alacritty; 
      description = "The terminal emulator used by this desktop";
    }; 
  };

  config = with lib; (mkMerge [
    (mkIf (cfg.terminal == pkgs.alacritty) (import ./alacritty.nix {}))
  ]);
}
