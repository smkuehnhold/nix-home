{ pkgs, ... }:

{
  programs.autorandr.hooks.preswitch = { 
    # autorandr postswitch to change the dpi
    "change-dpi" = ''
      case "$AUTORANDR_CURRENT_PROFILE" in
        away)
          DPI=192
          ;;
       	default)
          DPI=96
          ;;
      esac

      echo "Xft.dpi: $DPI" | ${pkgs.xorg.xrdb}/bin/xrdb -merge
    '';
  }; 
}
