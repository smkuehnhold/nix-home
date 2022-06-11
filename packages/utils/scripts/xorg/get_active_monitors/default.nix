{ 
  coreutils,
  xorg,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "get_active_monitors";
  text = (builtins.readFile ./get_active_monitors.sh); 
  runtimeInputs = [ coreutils xorg.xev xorg.xrandr ]; 
}


