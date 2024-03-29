{ lib, config, ... }:

let
  inherit (lib) types mkOption mkIf;

in {
  options = {
    my.obs.enable = mkOption {
      type = types.bool;
      description = "Rename of obs enable";
      default = false;
    };
  };

  config = {
    programs.obs-studio.enable = mkIf config.my.obs.enable true;
  };
}