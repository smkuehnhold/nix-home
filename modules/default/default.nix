{ pkgs, ... }: 

{
  imports = [
    ./bash
    ./nix-index
    ./xdg
  ];

  config = {
    home.packages = with pkgs; [ htop ];
  };
}