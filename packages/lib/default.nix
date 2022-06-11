{ writeTextFile, runtimeShell, lib, stdenv, ... }: rec { 
  # Like lib.writeShellScript except it allows you to define runtimeInputs like lib.writeShellApplication
  writeShellScriptBin = { 
    name, 
    text, 
    runtimeInputs ? []
  }:
    writeTextFile {
      inherit name;
      executable = true;
      destination = "/bin/${name}";
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
