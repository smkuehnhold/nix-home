{ 
  coreutils,
  xorg,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "get_monitor_size";
  text = (builtins.readFile ./get_monitor_size.sh); 
  runtimeInputs = [ coreutils xorg.xrandr my.utils.xorg.parseNodeSizeAndOffset ];
}