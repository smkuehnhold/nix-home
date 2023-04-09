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
    };

    extraConfig = ''
      SCALING_FACTOR="$(${getScalingFactor}/bin/get_scaling_factor)"

      export QT_AUTO_SCREEN_SCALE_FACTOR="$SCALING_FACTOR"
      export GDK_SCALE="$SCALING_FACTOR"
    '';

    # Need this because otherwise windows spawn on top of polybar
    # FIXME: has to be a better way
    # initExtra does not work because it occurs before bspwm starts
    xsession.windowManager.bspwm.extraConfig = ''
      systemctl --user restart polybar.service
    '';
  };
}
