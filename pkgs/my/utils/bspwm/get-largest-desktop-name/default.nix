{ 
  coreutils,
  bspwm,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "get-largest-desktop-name";
  text = (builtins.readFile ./get-largest-desktop-name.sh); 
  runtimeInputs = [ coreutils bspwm ]; 
}