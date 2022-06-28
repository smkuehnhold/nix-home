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
    ./xinitrc.nix
  ]; 

  config = {
    home.packages = with pkgs; [ discord ];
  };
}
