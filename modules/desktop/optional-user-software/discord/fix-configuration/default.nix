# This script updates discord's configuration to skip automatic updates

{ pkgs, ... }:

let
  inherit (pkgs) my jq;

  script = my.lib.writeShellScript {
    name = "fix_discord_configuration";
    text = builtins.readFile ./fix_discord_configuration.sh; 
    runtimeInputs = [ jq ];
  };

in script