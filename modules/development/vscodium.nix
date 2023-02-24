{ pkgs, ...}:

{

  home.packages = [
    pkgs.rnix-lsp # nix LSP for nix-ide
  ];

  # map codium to code
  home.shellAliases = {
    "code" = "codium";
  };

  programs.vscode = {
    enable = true;
    # use freely-licensed binary so I don't have to add to allowUnfreePredicate
    package = pkgs.vscodium; 
    extensions = [
      pkgs.vscode-extensions.jnoortheen.nix-ide

      # swift extension and dependencies
      pkgs.vscode-marketplace.sswg.swift-lang
      pkgs.vscode-marketplace.vadimcn.vscode-lldb
    ]; 
    # Needed to pass impurity check
    mutableExtensionsDir = false;
  };
}
