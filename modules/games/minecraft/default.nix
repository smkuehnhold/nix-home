{ pkgs, ... }:

{
  home.packages = with pkgs; [ prismlauncher ccemux ];
}
