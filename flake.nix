{
  description = "Sam Kuehnhold's home-manager configuration";

  inputs = {
    system-config.url = "/etc/nixos";
    nixpkgs.follows = "system-config/nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.11";
    home-manager.inputs.nixpkgs.follows = "system-config/nixpkgs"; # Pin home-manger to system nixpkgs
    nur.url = "github:nix-community/NUR";
    # nur overlay implicitly uses pkgs?
    # nur.inputs.nixpkgs.follows = "system-config/nixpkgs";
    # FIXME: KNOCK DELETED?!?!
    # knock.url = "github:BentonEdmondson/knock";
    # knock.inputs.nixpkgs.follows = "system-config/nixpkgs";
    wired.url = "github:Toqozz/wired-notify";
    wired.inputs.nixpkgs.follows = "system-config/nixpkgs";
    # Pin nix-vscode-extensions because latest seems to rely on unstable?                
    # https://github.com/nix-community/nix-vscode-extensions/issues/11
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/83b9f149ffc2a6cdd44d8083050e7e245706ae2f";
    nix-vscode-extensions.inputs.nixpkgs.follows = "system-config/nixpkgs";
  };

  outputs = { home-manager, nixpkgs, nur, wired, nix-vscode-extensions, ... }: let
    myPackages = (import ./packages {});
    mkSimpleOverlay = pkgName: pkg: (final: prev: {
      "${pkgName}" = pkg;
    });
  in {
    
    homeConfigurations = let
      system = "x86_64-linux";
    in {
      "smkuehnhold@smk-framework" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { 
          inherit system;
          overlays = [ nur.overlay myPackages.overlay wired.overlays.default ] ++
                     [ 
                       #(mkSimpleOverlay "knock" knock.packages."${system}".knock) 
                       nix-vscode-extensions.overlays.default
                     ];
          config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "steam" "steam-original" "steam-runtime" "discord" "minecraft" "minecraft-launcher" "steam-run"
          ];
        };
        modules = [
          {
            home = {
              username = "smkuehnhold";
              homeDirectory = "/home/smkuehnhold";
              stateVersion = "22.05";
            };
          }
          ./modules
          wired.homeManagerModules.default
        ];
      };
      "smkuehnhold@smk-desktop" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { 
          inherit system;
          overlays = [ nur.overlay myPackages.overlay wired.overlays.default ] ++
                     [ 
                       #(mkSimpleOverlay "knock" knock.packages."${system}".knock) 
                       nix-vscode-extensions.overlays.default
                     ];
          config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "steam" "steam-original" "steam-runtime" "discord" "minecraft" "minecraft-launcher" "steam-run"
          ];
        };
        modules = [
          {
            home = {
              username = "smkuehnhold";
              homeDirectory = "/home/smkuehnhold";
              stateVersion = "22.05";
            };
          }
          ./modules
          wired.homeManagerModules.default
        ];
      };
    };
  };
}
