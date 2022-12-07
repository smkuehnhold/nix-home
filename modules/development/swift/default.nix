{ pkgs, ... }:

{
  config = {
    home.packages = [
      # pin swift to a version that is available in hydra
      # it is really painful to actually "build" swift
      pkgs.swift
    ]; 
  };
}
