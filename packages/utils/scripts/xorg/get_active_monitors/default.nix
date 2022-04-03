{ my,
  xorg
}:

let
  inherit (xorg) xrandr;
  inherit (my.lib) writeShellScript;
  text = (builtins.readFile ./get_active_monitors.sh);
  name = "get_active_monitors";
in writeShellScript {
  inherit name text; 
  runtimeInputs = [ xrandr ];
} 


