{ pkgs, ... }:

{
  home.packages = with pkgs; [ knock ];
}
