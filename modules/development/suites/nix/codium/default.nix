{ pkgs, ... }:

{
  programs.vscode.extensions = with pkgs; [ pkgs.vscode-extensions.jnoortheen.nix-ide ];
}