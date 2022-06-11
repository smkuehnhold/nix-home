{
  description = "Sam Kuehnhold's home-manager configuration";

  inputs = {
    system-config.url = "/etc/nixos";
    nixpkgs.follows = "system-config/nixpkgs";
    home-manager.url = "github:nix-community/home-manager/release-22.05";
    home-manager.inputs.nixpkgs.follows = "system-config/nixpkgs"; # Pin home-manger to system nixpkgs
    nur.url = "github:nix-community/NUR";
    knock.url = "github:BentonEdmondson/knock";
  };

  outputs = { home-manager, nixpkgs, nur, knock, ... }: let
    myPackages = (import ./packages {});
    mkSimpleOverlay = pkgName: pkg: (final: prev: {
      "${pkgName}" = pkg;
    });
  in {
    
    homeConfigurations = {
      smkuehnhold = home-manager.lib.homeManagerConfiguration rec {
        pkgs = import nixpkgs { 
          system = "x86_64-linux";
          overlays = [ nur.overlay myPackages.overlay ] ++
                     [ (mkSimpleOverlay "knock" knock.packages.x86_64-linux.knock) ]; 
          config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
            "steam" "steam-original" "steam-runtime" "discord" "minecraft" "minecraft-launcher"
          ];
        };
        system = "x86_64-linux";
        homeDirectory = "/home/smkuehnhold";
        username = "smkuehnhold";
        extraModules = [
          ./modules 
        ];
        configuration = { };
      };
    };

  };



}
