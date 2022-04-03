# This module enables xsession and lets home-manager play nicely with nixos' "startx"
# Basically just moves the .xsession used by conventional display managers to .xinitrc expected by startx
# I believe this should be fine since both are basically just shell scripts

{ ... }:

{
  xsession = {
    enable = true;
    scriptPath = ".xinitrc";
  };
}
