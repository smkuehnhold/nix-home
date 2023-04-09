{ lib, config, pkgs, ... }:

with lib;

mkIf (builtins.elem "nix" config.my.development.suites) (mkMerge [
  {
    home.packages = [
      pkgs.rnix-lsp # nix LSP for nix-ide
    ];
  }
  (mkIf (builtins.elem "codium" config.my.development.editors) (import ./codium { inherit pkgs; }))
])