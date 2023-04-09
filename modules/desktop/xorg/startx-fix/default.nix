# This module enables xsession and lets home-manager play nicely with nixos' "startx"
# Basically just moves the .xsession used by conventional display managers to .xinitrc expected by startx
# I believe this should be fine since both are basically just shell scripts

{ system-config, ... }:

let
  isStartxEnabled = system-config.services.xserver.displayManager.startx.enable;
  extraCfg = if isStartxEnabled then {
    scriptPath = ".xinitrc";
  } else {};
in {
  xsession = extraCfg;
}