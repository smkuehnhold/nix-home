{ 
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "is_active_monitors";
  text = (builtins.readFile ./is_active_monitors.sh); 
  runtimeInputs = [ my.utils.xorg.getActiveMonitors ]; 
}


