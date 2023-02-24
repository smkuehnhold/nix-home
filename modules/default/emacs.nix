{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ 
    git
    ripgrep
    coreutils
    fd
    clang

    shellcheck
    discount
  ];

  programs.emacs.enable = true;
#  programs.bash.initExtra = ''
#    PATH="$HOME/.emacs.d/bin:$PATH"
#  '';
}
