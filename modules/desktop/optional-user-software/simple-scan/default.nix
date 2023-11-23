{ pkgs, ... }:

{
  # FIXME: Move into some kind of PDF feature?
  home.packages = with pkgs; [ 
   unstable.gnome.simple-scan # FIXME: Some issues with document alignment in the stable version?
   skanlite # A bit more customizable than simple-scan, but you can't scan into a single document?
   pdfarranger
  ];
}
