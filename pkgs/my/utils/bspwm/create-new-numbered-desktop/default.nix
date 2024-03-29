{ 
  coreutils,
  bspwm,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "create-new-numbered-desktop";
  text = (builtins.readFile ./create-new-numbered-desktop.sh); 
  runtimeInputs = [ my.utils.bspwm.getLargestDesktopName bspwm ]; 
}