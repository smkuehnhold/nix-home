{ writeShellScript, 
  validate-whole-decimal ? ( import ./validate-whole-decimal.nix { inherit writeShellScript; } ),
  validate-decimal ? ( import ./validate-decimal.nix { inherit writeShellScript; }),
  ceil ? ( import ./ceil.nix { inherit writeShellScript; } )  
}:

writeShellScript "lower-to-next-multiple" ''
  multiple=$1 # has to be whole-number (currently)
  decimal=$2

  if ${validate-whole-decimal} $multiple && ${validate-decimal} $decimal; then
    ceiled=$( ${ceil} $decimal )
    echo -n $(( ceiled - ( ( ( ceiled - 1 ) % multiple ) + 1 ) ))
  else
    exit 1
  fi
''


