{ lib, config, pkgs, ... }:

with lib;

mkIf (builtins.elem "codium" config.my.development.editors) {
  assertions = [
    {
      assertion = config.my.desktop.environment.enable;
      message = "Installation of codium editor requies that the desktop environment option is enabled";
    }
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;
    # FIXME: Extensions seem to not load if extensions dir is not mutable??
    # https://github.com/nix-community/home-manager/issues/3507
    mutableExtensionsDir = true;
    enableExtensionUpdateCheck = false;

    userSettings = {
      editor.minimap.enabled = false;
    };
  };

  # FIXME: maybe someway to do a similar mapping for .desktop??
  # map codium to code
  home.shellAliases = {
    "code" = "codium";
  };
}
