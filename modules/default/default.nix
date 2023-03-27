{ pkgs, ... }:

{
  imports = [
    ./bash.nix
#    ./git
#    ./gpg
    ./emacs.nix
    ./home-manager.nix
    ./htop.nix
    ./xdg.nix
  ];

  config = {
    home.packages = with pkgs; [ chromium ];
  };
}
