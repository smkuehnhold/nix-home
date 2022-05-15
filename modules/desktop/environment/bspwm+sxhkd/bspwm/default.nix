{ pkgs, ... }:
let 
  inherit (pkgs) lib;
  inherit (pkgs.my.packages.utils.scripts.xorg) getActiveMonitors;
in {
  # xtitle is used in a lot of bspc scripts to get sensible names
  # it is also useful to debug during runtime
  home.packages = [ pkgs.xtitle ];

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      "primary" = [ "1" "2" "3" "4" ];
    };
    extraConfig = ''
      PATH=${lib.makeBinPath [ getActiveMonitors ]}:$PATH 
    '';
  };
}
