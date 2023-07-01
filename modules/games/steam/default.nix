{ lib, config, pkgs, ... }:

with lib;

mkIf (builtins.elem "steam" config.my.games.suites) {
  home.packages = with pkgs; [
    # fixes ck3 linker error
    # https://forum.paradoxplaza.com/forum/threads/ck-iii-game-refuses-to-launch-with-steam-runtime-environment-on-linux-1-8-0.1560341/#post-28974552
    (steam.override {
      extraPkgs = pkgs: [ pkgs.ncurses6 ];
    })
  ];
}