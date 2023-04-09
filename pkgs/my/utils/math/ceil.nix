{ writeShellScript,
  floor ? ( import ./floor.nix { inherit writeShellScript; }),
  validateWholeDecimal ? ( import ./validate-whole-decimal.nix { inherit writeShellScript; } )
}:

writeShellScript "ceil" ''
  value=$1

  # if equivalent to a whole number
  if $(echo -n $value | grep -Eq "^([[:digit:]]+)(.0+)?$"); then
    echo -n $value | cut -d "." -f 1 | tr -d "\n"
    exit 0
  fi
  
  floor=$( ${floor} $value )
  if [ -z $floor ]; then
    exit 1
  else
    echo -n $(( floor + 1 ))
  fi
''
