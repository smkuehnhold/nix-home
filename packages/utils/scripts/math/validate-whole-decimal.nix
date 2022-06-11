{ writeShellScript }:

writeShellScript "validate-whole-decimal" ''
  value=$1

  echo -n $value | grep -Eq "^[[:digit:]]+$"
''
