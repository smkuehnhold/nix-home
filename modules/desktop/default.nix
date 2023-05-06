{ lib, config, system-config, pkgs, ... }:

with lib;

let

in {
  imports = [
    ./bases
    ./default-software
    ./gtk
    ./optional-user-software
    ./xorg
  ];

  options = {
    my.desktop.environment = {
      enable = mkOption {
        type = types.bool;
        default = false;
        description = ''
          If enabled, the home enviornment will be configured with a suite of graphical desktop software.

          The suite of software that is installed is controlled by my.desktop.environment.base
        '';
      };
  
      base = mkOption {
        type = types.enum [ "bspwm+sxhkd" ];
        default = "bspwm+sxhkd";
        description = ''
          Determines the "base" set of software for the graphical user environment.
        '';
      };
  
      includesOptionalUserSoftware = mkOption {
        type = types.bool;
        default = true;
        description = ''
          If enabled while the environment is enabled, installs and configures a collection of software that I would
          expect as a user (e.g. discord).

          Included because I sometimes want something a bit more minimal
        '';
      };
    };
  };
}