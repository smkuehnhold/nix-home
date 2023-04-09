{ lib, config, system-config, ... }:

with lib;

let
  cfg = config.my.desktop.environment;
  base = cfg.base;
  isXorgBased = base: {
    "bspwm+sxhkd" = true;
  }."${base}" or false;
  isXorgEnabled = system-config.services.xserver.enable;
  baseIsXorgBased = isXorgBased base;

in mkIf baseIsXorgBased (mkMerge [
  {
    assertions = [
      {
        assertion = (baseIsXorgBased) -> isXorgEnabled;
        message = "Enabling a Xorg-based suite when Xorg is not enabled at the system-level is invalid.";
      }
    ];

    xsession.enable = true;
  }
  (import ./autorandr {})
  (import ./startx-fix { inherit system-config; })
])
