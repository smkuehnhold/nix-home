{ lib, pkgs, ... }:

let
  fixConfigurationScript = import ./fix-configuration { inherit pkgs; };
in {
  home.packages = with pkgs; [ discord ];

  # Fix discord configuration on home-manager switch
  home.activation.fix-discord = (lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${fixConfigurationScript} $HOME
  '');
}