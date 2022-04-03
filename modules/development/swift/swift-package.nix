
# Pin swift to a specific revision because it is very large and is laible to break
# Also, we know that this one is cached on Hydra, so it is quick to install (no builds!)
{ fetchFromGitHub, system, ... }:

(import (fetchFromGitHub {
  owner = "NixOS";
  repo = "nixpkgs";
  rev = "2c1ce604773518f437c4989e8c591131bd1f746a";
  sha256 = "HrpfOYsm8ojPDw8XkGRx2NQQ0rUTVyb5xub33sfKjh8=";
}) { inherit system; }).swift
