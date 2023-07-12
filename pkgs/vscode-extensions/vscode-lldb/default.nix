# We need to get CodeLLDB manually because of this issue
# https://github.com/vadimcn/codelldb/issues/275#issuecomment-596376082
# TLDR: The package in vscode marketplace bootstraps install of deps depending on platform
#   This causes problems when the vscode extensions directory is immultable
#   (Causes a notification to appear permanently on vscode window that something is installing)

{ vscode-utils, fetchurl, ... }:

let
  vsix = fetchurl {
    url = "https://github.com/vadimcn/codelldb/releases/download/v1.5.1/codelldb-x86_64-linux.vsix";
    sha256 = "sha256-+yzy27Of9Dgx2c918zf4324W4pmih5kprJizpB7dU9c=";
    # Changing name comes from https://github.com/NixOS/nixpkgs/blob/cd34d6ed7ba7d5c4e44b04a53dc97edb52f2766c/pkgs/applications/editors/vscode/extensions/vscode-utils.nix#L45
    # Apparently buildVscodeExtension expects a zip and vsix is just a zip?
    name = "vadimcn-vscode-lldb.zip";
  };
in vscode-utils.buildVscodeExtension {
  name = "CodeLLDB";
  src = vsix;
  version = 1; # FIXME: What is this?
  vscodeExtName = "vscode-lldb";
  vscodeExtPublisher = "vadimcn";
  vscodeExtUniqueId = "vadimcn.vscode-lldb";
}