{ writeTextFile, runtimeShell, lib, stdenv, ... }: { 
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
        export PATH="${lib.makeBinPath runtimeInputs}:$PATH"

        ${text}
        '';
      # FIXME: No attribute 'shellDryRun'. Perhaps would work in a newer version of nix
      # {stdenv.shellDryRun} "$target"
      # Doing it the old way for now
      checkPhase = '' 
        ${stdenv.shell} -n $target
      '';
    };
}
