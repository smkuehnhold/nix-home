{ lib, config, system-config, ... }:

with lib;

# https://github.com/noisetorch/NoiseTorch/wiki/Start-automatically-with-Systemd
let
  # Blue Yeti
  device = {
    unit = "\"sys-devices-pci0000:00-0000:00:02.1-0000:05:00.0-0000:06:08.0-0000:08:00.0-0000:09:0c.0-0000:69:00.0-usb3-3\\\\x2d4-3\\\\x2d4:1.0-sound-card1-controlC1.device\"";
    id = "alsa_input.usb-Generic_Blue_Microphones_201701110001-00.analog-stereo";
  };
  noisetorch = "${system-config.programs.noisetorch.package}/bin/noisetorch";
in (mkIf (system-config.programs.noisetorch.enable == true) {
  systemd.user.services.noisetorch = {
    Unit = {
      Description = "Noisetorch";
      Requires = ["pipewire.service" device.unit];
      After = ["pipewire.service" device.unit];
    };

    Service = {
      Type = "simple";
      RemainAfterExit = "yes";
      ExecStart = "${noisetorch} -i -s ${device.id} -t 95";
      ExecStop = "${noisetorch} -u";
    };

    Install = {
      WantedBy = ["default.target"];
    };
  };
})