{ lib, pkgs, config, system-config, ... }:

with lib;

# https://github.com/noisetorch/NoiseTorch/wiki/Start-automatically-with-Systemd
let
  # Blue Yeti
  device = {
    # TODO: Figure out what the difference between these units are
    # TODO: Look into udev to see if we can give the microphone a symbolic name. It looks like the unit name here might change depending on which port the mic is plugged into?
    # unit = "\"sys-devices-pci0000:00-0000:00:02.1-0000:05:00.0-0000:06:08.0-0000:08:00.0-0000:09:0c.0-0000:69:00.0-usb3-3\\\\x2d4-3\\\\x2d4:1.0-sound-card1-controlC1.device\"";
    unit = "dev-snd-controlC3.device";
    id = "alsa_input.usb-Generic_Blue_Microphones_201701110001-00.analog-stereo";
  };
  noisetorchDevice = {
    name = "NoiseTorch Microphone for Blue Microphones";
  };
  noisetorch = "${system-config.programs.noisetorch.package}/bin/noisetorch";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  fixConfiguration = pkgs.callPackage ./fix-configuration {};
in (mkIf (system-config.programs.noisetorch.enable == true) {
  systemd.user.services.noisetorch = {
    Unit = {
      Description = "Noisetorch";
      BindsTo = ["pipewire.service" device.unit];
      After = ["pipewire.service" device.unit];
    };

    Service = {
      Type = "simple";
      RemainAfterExit = "yes";
      ExecStartPre = "${fixConfiguration} %h";
      ExecStart = "${noisetorch} -i -s ${device.id} -t 85";
      ExecStop = "${noisetorch} -u";
      Restart="on-failure";
      RestartSec="4";
    };

    Install = {
      WantedBy = [
        device.unit
      ];
    };
  };

  systemd.user.services.noisetorch-source-set-default-volume = {
    Unit = {
      Description = "Oneshot service to set default volume for the Noisetorch audio source";
      Requires = [ "noisetorch.service" ];
      After = [ "noisetorch.service" ];
    };

    Service = {
      Type = "oneshot";
      Environment = "NOISETORCH_DEVICE_NAME=\"${noisetorchDevice.name}\"";
      ExecStart = "${pamixer} --source \${NOISETORCH_DEVICE_NAME} --set-volume 80";
      Restart = "on-failure";
      RestartSec = 2;
    };

    Install = {
      WantedBy = [
        "noisetorch.service"
      ];
    };
  };
})
