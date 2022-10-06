{ pkgs, ... }:

{
  imports = [ 
    ./audio
    ./browser
    ./environment
    ./launcher
    ./notifications
    ./status-bar
    ./terminal
    ./video
    ./xinitrc.nix
  ]; 

  config = {
    home.packages = with pkgs; [ discord ];
  };
}
