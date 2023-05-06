{ pkgs, ... }:

# lots of gtk-based software seems to expect fonts in the environment
# this module provides those fonts
{
  home.packages = with pkgs; [
    gnome3.adwaita-icon-theme
    cantarell-fonts
  ];
}