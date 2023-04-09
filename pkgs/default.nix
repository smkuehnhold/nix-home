{ lib, ... }:

{ 
  nixpkgs.overlays = [(self: super: {
    vscode-extensions = super.vscode-extensions // ( super.callPackage ./vscode-extensions {});
    my = super.callPackage ./my {};
  })];
}