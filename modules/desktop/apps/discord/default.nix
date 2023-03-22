{ pkgs, ... }:

{
  imports = [
    ./fix-discord-configuration
  ];

  config = {
    home.packages = with pkgs; [ discord ];
  };
}