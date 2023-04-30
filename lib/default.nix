{ system-flake, nixpkgs, nixpkgs-unstable, home-manager, ... }:

let
  unfreePkgWhitelist = (import ./unfree-pkg-whitelist.nix);

  mkSimplePredicate = list: check: item: builtins.elem (check item) list;
in {
  const = {
    users = nixpkgs.lib.mapAttrsToList (username: _: username) (builtins.readDir ../users);
  };

  mkUser = {
    fullUsername,
    extraBaseModules ? []
  }:
    let
      user = builtins.listToAttrs (nixpkgs.lib.zipListsWith (name: value: 
        { 
          inherit name value; 
        }) [ "name" "host" ] (nixpkgs.lib.splitString "@" fullUsername));
      system = system-flake.outputs.nixosConfigurations."${user.host}".pkgs.system;
      basePkgs = system-flake.inputs.nixpkgs.legacyPackages."${system}";
      unstablePkgs = import nixpkgs-unstable { inherit system; };
      systemConfig = system-flake.outputs.nixosConfigurations."${user.host}".config;
    in {
      "${fullUsername}" = home-manager.lib.homeManagerConfiguration {
        pkgs = basePkgs; # Use the host's pkgs as a base.
        modules = [
          ../modules
          ../pkgs
          (../users + "/${fullUsername}")
          ({ pkgs, ... }: {
            nixpkgs = {
              config.allowUnfreePredicate = mkSimplePredicate unfreePkgWhitelist nixpkgs.lib.getName;
              overlays = [
                (self: super: {
                  unstable = unstablePkgs;
                })
              ];
            };

            _module.args = {
              system-config = systemConfig; # pass system configuration to modules
            };

            # home.packages = with pkgs; [ home-manager ]; doesn't work because home-manager resolves to the module
            home.packages = [ pkgs.home-manager ];
          })
        ] ++ extraBaseModules;
      };
    };
}
