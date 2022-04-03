{ ... }:

{

  overlay = final: prev: {
    my = rec {
      lib = (prev.callPackage ./lib {});
      packages = {
         utils = (prev.callPackage ./utils {});
         firefoxAddons = (prev.callPackage ./firefox-addons {});
      };
    }; 
  };

}
