{ pkgs, ... }:

let
  inherit (pkgs) my dasel;

  script = my.lib.writeShellScript {
    name = "fix_noisetorch_configuration";
    text = builtins.readFile ./fix_noisetorch_configuration.sh;
    runtimeInputs = [ dasel ];
  };

in script
