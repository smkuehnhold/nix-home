{ lib, config, ... }:

with lib;

{
  imports = [
    ./lutris
    ./minecraft
    ./steam
  ];

  options = {
    my.games.suites = mkOption {
      type = types.listOf (types.enum [ "lutris" "minecraft" "steam" ]);
      default = [];
      description = ''
        List of game "suites" to install.

        (WARNING: game suites require a desktop environment to be installed)
      '';
    };
  };

  config = {
    assertions = [
      {
        assertion = (builtins.length config.my.games.suites > 0) -> config.my.desktop.environment.enable;
        message = "Game suites require that a desktop environment is enabled";
      }
    ];
  };
}