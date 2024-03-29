{ lib, config, pkgs, ... }:

with lib;

mkIf (builtins.elem "swift" config.my.development.suites) (mkMerge [
  {
    # home.packages = with pkgs; [ swift ]; 
  }
  (mkIf (builtins.elem "codium" config.my.development.editors) (import ./codium { inherit pkgs; }))
])