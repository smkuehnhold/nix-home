{ pkgs, ... }:

{
  home.packages = with pkgs; [
    shellcheck # a nice linter
  ];

  programs.bash.enable = true;
}