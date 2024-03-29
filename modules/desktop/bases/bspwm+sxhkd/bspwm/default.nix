{ pkgs, ... }:

let 
  inherit (pkgs) bspwm;
  inherit (pkgs.my.utils.xorg) getScalingFactor;
in {
  home.packages = [ pkgs.xtitle ];

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      "primary" = [ "1" "2" "3" "4" ];
      # "DP-3" = [ "1" "2" "3" "4" ];
      # "HDMI-1" = [ "5" "6" "7" "8" ]; 
    };

    # Need to restart polybar because otherwise windows spawn on top of polybar
    # FIXME: has to be a better way
    # initExtra does not work because it occurs before bspwm starts
    extraConfig = ''
      SCALING_FACTOR="$(${getScalingFactor}/bin/get_scaling_factor)"

      export QT_AUTO_SCREEN_SCALE_FACTOR="$SCALING_FACTOR"
      export GDK_SCALE="$SCALING_FACTOR"

      systemctl --user restart polybar.service
    '';
  };
}
