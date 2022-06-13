{ pkgs, ... }:

{

  # enable nix-index as command-not-found
  # FIXME: What if bash is not my interactive shell?
  programs.nix-index = {
    enable = true;
    enableBashIntegration = true;
  };
}
