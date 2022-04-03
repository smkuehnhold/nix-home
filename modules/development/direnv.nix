{ ... }:

{
  config = {
    # override direnv so it uses nixUnstable
    # I think enableFlakes should fix this, but it is not...
    nixpkgs.overlays = [
      (final: prev: {
        nix-direnv = prev.nix-direnv.override {
          nix = prev.nixUnstable; 
        };
      })
    ];

    programs.direnv = {
      enable = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
  };
}
