{ lib, ... }:

let
  recursiveUpdateAttrsList = attrsList: 
    builtins.foldl' (acc: next: lib.recursiveUpdate acc next) {} attrsList;

  mkAutorandrMonitor = 
    {
      port,
      fingerprint,
      ...
    }@args: {
      inherit port;

      fingerprint = 
        if builtins.isString fingerprint then
          fingerprint
        else if builtins.isPath fingerprint then
          builtins.readFile fingerprint
        else
          abort "A monitors fingerprint must be a string or a path.";
  
      config = builtins.removeAttrs (args) [ "port" "fingerprint" ];
    };

  mkAutorandrProfile = monitors:
    let
      monitorData = 
        if builtins.isPath monitors then
          lib.mapAttrsToList (name: _: import ("${monitors}/${name}") { inherit mkAutorandrMonitor; }) (builtins.readDir monitors)
        else
          monitors;
    in recursiveUpdateAttrsList (builtins.map (monitor: {
      fingerprint.${monitor.port} = monitor.fingerprint;
      config.${monitor.port} = monitor.config;
    }) monitorData);

  mkAutorandrProfilesFromPath = profilesPath:
    if builtins.isPath profilesPath then
      builtins.mapAttrs
        (name: _: mkAutorandrProfile (profilesPath + "/${name}"))
        (builtins.readDir profilesPath)
    else
      abort "The argument to mkAutorandrProfilesFromPath must be a path";
in {
  inherit mkAutorandrMonitor mkAutorandrProfile mkAutorandrProfilesFromPath;
}