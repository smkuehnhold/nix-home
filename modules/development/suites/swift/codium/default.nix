{ pkgs, ... }:

{
  programs.vscode.extensions = with pkgs; [  
    vscode-marketplace.sswg.swift-lang
    vscode-extensions.vscode-lldb
  ];
}
