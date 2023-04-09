{ lib, ... }:

with lib;

{
  imports = [
    ./editors
    ./suites
  ];

  options = {
    my.development.editors = mkOption {
      type = types.listOf (types.enum [ "codium" ]);
      default = [ ];
      description = ''
        Determines which code editor(s) to install and configure for each selected development suite.

        WARNING: Some editors require that the desktop environment is enabled (e.g. codium).
      '';
    };

    my.development.suites = mkOption {
      type = types.listOf (types.enum [ "nix" "swift" ]);
      default = [ "nix" ];
      description = ''
        Determines which development suites to install into the user environment.
      '';
    };
  };
}