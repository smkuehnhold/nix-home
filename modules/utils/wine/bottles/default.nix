{ pkgs, ... }:

{
  home.packages = with pkgs.my.packages; [ bottles ];
}
