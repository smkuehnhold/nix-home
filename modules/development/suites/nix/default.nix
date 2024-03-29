{ lib, config, pkgs, ... }:

with lib;

mkIf (builtins.elem "nix" config.my.development.suites) (mkMerge [
  {
    home.packages = [

    ];
  }
  (mkIf (builtins.elem "codium" config.my.development.editors) (import ./codium { inherit pkgs; }))
])