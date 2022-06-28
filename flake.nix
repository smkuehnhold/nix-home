{
  description = "Sam Kuehnhold's home-manager configuration";

  inputs = {
    system-config.url = "/etc/nixos";
    nixpkgs.follows = "system-config/nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "system-config/nixpkgs"; # Pin home-manger to system nixpkgs
    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "system-config/nixpkgs";
    knock.url = "github:BentonEdmondson/knock";
    knock.inputs.nixpkgs.follows = "system-config/nixpkgs";
    wired.url = "github:Toqozz/wired-notify";
    wired.inputs.nixpkgs.follows = "system-config/nixpkgs";
  };

  outputs = { home-manager, nixpkgs, nur, knock, wired, ... }: let
    myPackages = (import ./packages {});
    mkSimpleOverlay = pkgName: pkg: (final: prev: {
      "${pkgName}" = pkg;
    });
  in {
    
    homeConfigurations = {
      smkuehnhold = home-manager.lib.homeManagerConfiguration rec {
        system = "x86_64-linux";
        pkgs = import nixpkgs { 
          inherit system;
          overlays = [ nur.overlay myPackages.overlay wired.overlays."${system}" ] ++
                     [ (mkSimpleOverlay "knock" knock.packages."${system}".knock) ]; 
          config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "steam" "steam-original" "steam-runtime" "discord" "minecraft" "minecraft-launcher"
          ];
        };
        homeDirectory = "/home/smkuehnhold";
        username = "smkuehnhold";
        extraModules = [
          ./modules 
          wired.homeManagerModules.default
        ];
        configuration = { };
      };
    };

  };



}
