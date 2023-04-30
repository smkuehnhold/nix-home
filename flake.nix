{
  inputs = {
    # system-config
    # FIXME: what happens if system does not have a flake located at /etc/nixos ???
    # FIXME: this also means I have to keep my hosts in sink??? that sounds bogus...
    system-flake.url = "/etc/nixos";

    # nixpkgs (depends on system-flake)
    nixpkgs.follows = "system-flake/nixpkgs";
  
    nixpkgs-unstable.url = github:NixOS/nixpkgs/nixpkgs-unstable;

    # home-manager
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix-user-repository
    nur.url = "github:nix-community/NUR";
  
    # vscode-extensions
    # Pin nix-vscode-extensions because latest seems to rely on unstable?                
    # https://github.com/nix-community/nix-vscode-extensions/issues/11
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/83b9f149ffc2a6cdd44d8083050e7e245706ae2f";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    # wired
    wired.url = "github:Toqozz/wired-notify";
    wired.inputs.nixpkgs.follows = "nixpkgs";

    # FIXME: KNOCK DELETED?!?!
    # knock.url = "github:BentonEdmondson/knock";
    # knock.inputs.nixpkgs.follows = "system-config/nixpkgs";
  };

  outputs = { self, system-flake, nixpkgs, nixpkgs-unstable, home-manager, nur, nix-vscode-extensions, wired }:

  let
    lib = (import ./lib { inherit system-flake nixpkgs nixpkgs-unstable home-manager; });

  in {
    homeConfigurations = builtins.foldl' (acc: nextUser: 
      acc // (lib.mkUser { 
        fullUsername = nextUser;
        extraBaseModules = [
          ({pkgs, ... }: {
            imports = [
              wired.homeManagerModules.default
            ];

            nixpkgs.overlays = [
              nix-vscode-extensions.overlays.default
              nur.overlay
              wired.overlays.default
            ];
          })
        ];
      })
    ) {} lib.const.users;
  };
}
