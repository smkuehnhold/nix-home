{ pkgs, ... }:

{
  home.packages = with pkgs; [ unstable.appflowy ];
}