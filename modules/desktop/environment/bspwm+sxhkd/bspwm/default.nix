{ pkgs, ... }:
let 
  inherit (pkgs) lib bspwm;
  inherit (pkgs.xorg) xrandr;
  inherit (pkgs.my.lib) writeShellScriptBin;
  inherit (pkgs.my.packages.utils.scripts.xorg) getActiveMonitors;
in {
  # xtitle is used in a lot of bspc scripts to get sensible names
  # it is also useful to debug during runtime
  home.packages = [ pkgs.xtitle ];

  # Put in bspwm.extraConfigEarly when migrating to a version of
  #  hm where it is available
  # also just need to fix the script..
#  xsession.initExtra = lib.mkBefore ''
#    . ${getActiveMonitors}/bin/get_active_monitors >> /dev/null
#
#    for monitor in "''${C_ACTIVE_MONITORS[@]}" do
#      if [ "$monitor" == "DP-1" ]; then
#        ${xrandr}/bin/xrandr --output "DP-1" --primary" 
#        ${xrandr}/bin/xrandr --output "eDP-1" --same-as "DP-1"
#        break
#      fi
#    done
#  '';

  xsession.windowManager.bspwm = {
    enable = true;
    monitors = {
      "primary" = [ "1" "2" "3" "4" ];
  #     "eDP-1" = [ "1" "2" "3" "4" ];
  #     "DP-1" = ["5" "6" "7" "8" ];
    };
#    extraConfig = ''
      # show cursor before any windows open
#      xsetroot -cursor_name left_ptr

      #${writeShellScriptBin {
      #  name = "bspwm_startup";
      #  text = builtins.readFile ./startup.sh;
      #  runtimeInputs = [ xrandr getActiveMonitors ];
      #}}/bin/bspwm_startup

      #bspc monitor 'primary' -d '1' '2' '3' '4'
#    '';
  };

  # Restart bspwm when autorandr mode switches
  # FIXME: Want a fancier preswitch that moves the monitors...
  programs.autorandr.hooks.preswitch."remove-desktops" = ''
    ${bspwm}/bin/bspc monitor primary --remove
  '';

  programs.autorandr.hooks.postswitch."restart-bspwm" = ''
    ${bspwm}/bin/bspc wm -r 
  '';
}
