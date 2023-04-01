{ pkgs, ... }:

{

  imports = [ 
    ./minecraft
  ];

  config = {
    home.packages = with pkgs; [ 
      (lutris-free.override {
        extraPkgs = pkgs: [ 
          pkgs.libnghttp2 # fixes battlenet bug https://github.com/NixOS/nixpkgs/issues/214375
          pkgs.gnome3.adwaita-icon-theme # for lutris font
        ];
      })
      steam
    ];
  };
}
