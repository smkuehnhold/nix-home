{ 
  coreutils,
  my,
  ...
}: my.lib.writeShellScriptBin { 
  name = "parse_node_size_and_offset";
  text = (builtins.readFile ./parse_node_size_and_offset.sh); 
  runtimeInputs = [ coreutils ];
}