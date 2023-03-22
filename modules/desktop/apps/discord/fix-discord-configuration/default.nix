{ pkgs, lib, ... }:

let
  inherit (pkgs) my jq;

  script = my.lib.writeShellScriptBin {
    name = "fix_discord_configuration";
    text = builtins.readFile ./fix_discord_configuration.sh; 
    runtimeInputs = [ jq ];
  };
  scriptPath = "${script}/bin/fix_discord_configuration";

in {
  # FIXME: Don't know if the service is necessary???
  # systemd.user.services.discord-fix = {
  #   Unit = {
  #     Description = "Discord Configuration Patcher";
  #     After = [ "default.target" ];
  #   };

  #   Service = {
  #     Type = "oneshot";
  #     ExecStart = "${scriptPath}/bin/fix_discord_configuration %h";
  #   };

  #   Install = {
  #     WantedBy = [ "default.target" ];
  #   };
  # };

  # Make sure that the configuration is updated upon home-manager switch
  home.activation.fix-discord = (lib.hm.dag.entryAfter ["writeBoundary"] ''
    $DRY_RUN_CMD ${scriptPath} $HOME
  '');
}