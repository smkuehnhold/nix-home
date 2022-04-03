{ config, lib, pkgs, ... }:
let
  cfg = config.my.home;
in with lib; {
  options = {
    my.home.browser = mkOption {
      type = types.enum [ "firefox" ];
      default = "firefox";
      description = "The default browser for this desktop";
    };
  };

  config = (mkMerge [
    (mkIf (cfg.browser == "firefox") (import ./firefox { inherit pkgs lib; }))
  ]);
}
