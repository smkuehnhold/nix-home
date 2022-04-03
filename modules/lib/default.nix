{ lib, callPackage, config, ... }:

with lib; {
  options = {
    my.lib = mkOption {
      type = types.package;
      default = ( callPacakge ../../packages/lib {}); 
      description = "Custom utility functions written by Sam Kuehnhold";
      readOnly = true;
    };     
  };
}
