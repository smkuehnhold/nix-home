{ my
  xorg
}:
let
  inherit (xorg) xrandr;
  inherit (my) getActiveMonitors;
in writeShellScript "is_active_monitor" ''


'' [ getActiveMonitors xorg ]


