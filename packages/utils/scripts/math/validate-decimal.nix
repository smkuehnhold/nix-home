{ writeShellScript }:

writeShellScript "validate-decimal" ''
  decimal=$1

  echo $decimal | grep -Eq "^[[:digit:]]+(.[[:digit:]]+)?$"
''
