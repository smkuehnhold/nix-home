{ 
  gnugrep,
  my,
  xorg,
  ...
}: my.lib.writeShellScriptBin { 
  name = "get_scaling_factor";
  text = (builtins.readFile ./get_scaling_factor.sh); 
  runtimeInputs = [ gnugrep xorg.xrdb ];
}


