{ pkgs, ... }:

{
  imports = [ 
    ./audio
    ./browser
    ./environment
    ./launcher
    ./status-bar
    ./terminal
    ./xinitrc.nix
  ]; 

  config = {
    home.packages = with pkgs; [ discord ];
  };
}
