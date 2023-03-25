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
    with pkgs; [ chromium ];
  };
}
