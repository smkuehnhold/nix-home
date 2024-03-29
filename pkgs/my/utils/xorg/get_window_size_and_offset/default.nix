{ 
  coreutils,
  xorg,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "get_window_size_and_offset";
  text = (builtins.readFile ./get_window_size_and_offset.sh); 
  runtimeInputs = [ coreutils xorg.xwininfo my.utils.xorg.parseNodeSizeAndOffset my.utils.xorg.getMonitorSize ];
}