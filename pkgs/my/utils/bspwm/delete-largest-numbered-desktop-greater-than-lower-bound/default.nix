{ 
  bspwm,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "delete-largest-numbered-desktop-greater-than-lower-bound";
  text = (builtins.readFile ./delete-largest-numbered-desktop-greater-than-lower-bound.sh); 
  runtimeInputs = with my.utils.bspwm; [ bspwm getLargestDesktopName getSmallestDesktopName ]; 
}