{ pkgs, ... }:

{
  config = {
    programs.bash.enable = true;
    home.packages = with pkgs; [
      shellcheck
    ];
  };
}
