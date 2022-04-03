{ pkgs, ... }:

{
  home.packages = with pkgs; [ home-manager ];
  home.enableNixpkgsReleaseCheck = true;
}
