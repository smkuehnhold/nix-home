{ writeTextFile, runtimeShell, lib, stdenv, ... }:

rec {
  writeShellScript = { 
    name, 
    text, 
    runtimeInputs ? [],
    destinationRoot ? ""
  }:
    writeTextFile {
      inherit name;
      executable = true;
      text = ''
        #!${runtimeShell}
        ${makePathExport { inherit runtimeInputs; }}

        ${text}
        '';
      # FIXME: No attribute 'shellDryRun'. Perhaps would work in a newer version of nix
      # {stdenv.shellDryRun} "$target"
      # Doing it the old way for now
      checkPhase = '' 
        ${stdenv.shell} -n $target
      '';
    } // ( if destinationRoot != "" then { destination = "${destinationRoot}${name}"; } else {});

  writeShellScriptBin = { 
    name, 
    text, 
    runtimeInputs ? []
  }:
    writeShellScript {
      inherit name text runtimeInputs;
      destinationRoot = "/bin/";
    };

  makePathExport = {
    runtimeInputs ? []
  }: "export PATH=\"${lib.makeBinPath runtimeInputs}:$PATH\"";

  # read a script from a file and add inputs to its path
  readScript = {
    path,
    runtimeInputs ? []
  }: ''
   ${makePathExport { inherit runtimeInputs; }} 

   ${builtins.readFile path}
  '';
}