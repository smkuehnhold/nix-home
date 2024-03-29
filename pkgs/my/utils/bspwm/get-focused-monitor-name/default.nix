{ 
  bspwm,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "get-focused-monitor-name";
  text = (builtins.readFile ./get-focused-monitor-name.sh); 
  runtimeInputs = [ bspwm ]; 
}