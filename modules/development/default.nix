{ pkgs, ... }: 

{
  imports = [
    ./direnv.nix
    ./swift
    ./vscodium
  ];  
}

