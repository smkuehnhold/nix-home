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
    home-manager.url = "github:nix-community/home-manager/release-23.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # nix-user-repository
    nur.url = "github:nix-community/NUR";
  
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions";
    nix-vscode-extensions.inputs.nixpkgs.follows = "nixpkgs";

    # wired
    wired.url = "github:Toqozz/wired-notify";
    wired.inputs.nixpkgs.follows = "nixpkgs";

    # TODO: Check if merged
    # Temporarily pull down this commit for access to keymapp
    nixpkgs-keymapp.url = "github:NixOS/nixpkgs/d79e616abf6b5c9928f19710d408b278142ede9c";
  };

  outputs = { self, system-flake, nixpkgs, nixpkgs-unstable, home-manager, nur, nix-vscode-extensions, wired, nixpkgs-keymapp }:

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

            # temp

            home.packages = let
              inherit (pkgs) system;

              keymapp = nixpkgs-keymapp.legacyPackages.${system}.keymapp.override {
                inherit (pkgs) stdenv lib fetchurl autoPatchelfHook wrapGAppsHook libusb1 webkitgtk gtk3 writeShellScript makeDesktopItem copyDesktopItems;
              };
            in [ keymapp pkgs.libgourou pkgs.foliate ];

            services.kdeconnect = {
              enable = true;
              indicator = true;
            };

            nixpkgs.config.permittedInsecurePackages = [
              "nix-2.15.3"
            ];

            home.file."Documents/nixpkgs".source = nixpkgs;
            home.file."Documents/home-manager".source = home-manager;
          })
      
          ({ pkgs, ... }: {
            home.packages = with pkgs; [ onlyoffice-bin bookworm ];
          })
          ({ pkgs, ... }: {
	    # tmp fcitx
            i18n.inputMethod = {
              enabled = "fcitx5";
              fcitx5.addons = with pkgs; [ fcitx5-mozc ];
            };
          })
          ({ pkgs, ... }: {
            gtk.theme.package = pkgs.colloid-gtk-theme.override {
              tweaks = [ "black" "rimless" ];
            };
          })
        ];
      })
    ) {} lib.const.users;
  };
}
