{ writeTextFile, runtimeShell, lib, stdenv, ... }: { 
  writeShellScript = {
		name,
		text,
		runtimeInputs ? []
	}: writeTextFile {
		inherit name;
		executable = true;
		text = ''
			#!${runtimeShell} 
			export PATH="${lib.makeBinPath runtimeInputs}:$PATH"
			
			${text} 
		'';
		checkPhase = ''
			# FIXME: No attribute 'shellDryRun'. Perhaps would work in a newer version of nix
			# {stdenv.shellDryRun} "$target"
			# Doing it the old way for now
			${stdenv.shell} -n $out
		'';
	};
}
