{ 
  coreutils,
  bspwm,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "get-smallest-desktop-name";
  text = (builtins.readFile ./get-smallest-desktop-name.sh); 
  runtimeInputs = [ coreutils bspwm ]; 
}