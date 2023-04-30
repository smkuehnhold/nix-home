{ lib, config, pkgs, ... }:

with lib;

mkIf (builtins.elem "lutris" config.my.games.suites) {
  home.packages = with pkgs.unstable; [ wine-staging (lutris-free.override {
    extraPkgs = pkgs: [ 
      pkgs.libnghttp2 # fixes battlenet bug https://github.com/NixOS/nixpkgs/issues/214375
      pkgs.gnome3.adwaita-icon-theme # for lutris font
    ];
  })];
}