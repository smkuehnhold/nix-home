{ writeShellScript, 
  validate-whole-decimal ? ( import ./validate-whole-decimal.nix { inherit writeShellScript; } ),
  floor ? ( import ./floor.nix { inherit writeShellScript; } )  
}:

writeShellScript "raise-to-next-multiple" ''
  multiple=$1 # has to be whole-number (currently)
  decimal=$2

  if ${validate-whole-decimal} $multiple; then
    floored=$( ${floor} $decimal )
    remainder=$(( floored % multiple ))
    echo -n $(( (floored - remainder) + multiple ))
  else
    exit 1
  fi
''


