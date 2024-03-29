{ pkgs, lib, ... }:

{
  programs.autorandr.enable = true;
  services.autorandr.enable = true;

  programs.autorandr.profiles = pkgs.my.lib.mkAutorandrProfilesFromPath ./profiles;
    # builtins.mapAttrs 
    #   (name: _: pkgs.my.lib.mkAutorandrProfile (./profiles + "/${name}")) 
    #   (builtins.readDir ./profiles);

  # Restart bspwm when autorandr mode switches
  # FIXME: Want a fancier preswitch that moves the monitors...
  programs.autorandr.hooks.preswitch."remove-desktops" = ''
    ${pkgs.bspwm}/bin/bspc monitor primary --remove
  '';

  programs.autorandr.hooks.postswitch."restart-bspwm" = ''
    ${pkgs.bspwm}/bin/bspc wm -r 
  '';
}