{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ 
    git
    emacs 
    ripgrep
    coreutils
    fd
    clang

    shellcheck
    discount
  ];
  programs.bash.initExtra = ''
    PATH="$HOME/.emacs.d/bin:$PATH"
  '';
}
