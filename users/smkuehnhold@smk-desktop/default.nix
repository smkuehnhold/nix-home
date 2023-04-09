{ pkgs, ... }: 

{
  imports = [
    ./noisetorch
  ];

  config = {
    home.packages = with pkgs; [ home-manager ];

    home = {
      username = "smkuehnhold";
      homeDirectory = "/home/smkuehnhold";
      stateVersion = "22.05";
    };

    my.desktop.environment = {
      enable = true;
      base = "bspwm+sxhkd";
      includesOptionalUserSoftware = true;
    };

    my.development = {
      editors = [ "codium" ];
      suites = [ "nix" "swift" ];
    };

    my.games.suites = [ "lutris" "minecraft" "steam" ];
  };

}
