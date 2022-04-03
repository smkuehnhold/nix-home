{ writeShellScript,
  validate-decimal ? (import ./validate-decimal.nix { inherit writeShellScript; })
}:

writeShellScript "floor" ''
  value=$1

  if ${validate-decimal} $value; then
    echo $value | cut -d "." -f 1 | tr -d "\n"
  else
    exit 1
  fi
''
