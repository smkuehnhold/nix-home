{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
    lutris-free 
    gnome3.adwaita-icon-theme # for lutris font
    steam
    multimc
  ];
}
