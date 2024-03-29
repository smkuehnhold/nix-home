{ 
  coreutils,
  bspwm,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "move-floating-node-to-edge";
  text = (builtins.readFile ./move-floating-node-to-edge.sh); 
  runtimeInputs = with my; [ coreutils bspwm utils.bspwm.getFocusedMonitorName utils.xorg.getWindowSizeAndOffset utils.xorg.getMonitorSize ]; 
}