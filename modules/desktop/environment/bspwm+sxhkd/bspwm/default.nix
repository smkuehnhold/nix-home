{ pkgs, ... }:

let
  utils = pkgs.my.packages.utils;
in {
  # xtitle is used in a lot of bspc scripts to get sensible names
  home.packages = [ pkgs.xtitle ];

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      "primary" = [ "1" "2" "3" "4" ];
    };
    extraConfig = ''
      ${utils.scripts.xorg.getActiveMonitors}
      ${utils.scripts.xorg.getActiveMonitors}
    '';
  };
}
