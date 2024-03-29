{ pkgs, lib, ... }:

# pkgs.fetchFirefoxAddon {
#   name = "rikaitan";
#   url = "https://addons.mozilla.org/firefox/downloads/file/4246908/rikaitan-24.3.7.1.xpi";
#   sha256 = "sha256-24STQ7ApsvG1EMxmAyFXUC4/6eYWgHLSfoqtmGe27Bc=";
# }

pkgs.my.lib.buildFirefoxXpiAddon {
  pname = "rikaitan";
  version = "24.3.7.1";
  addonId = "tatsu@autistici.org";
  url = "https://addons.mozilla.org/firefox/downloads/file/4246908/rikaitan-24.3.7.1.xpi";
  sha256 = "24STQ7ApsvG1EMxmAyFXUC4/6eYWgHLSfoqtmGe27Bc=";
  meta = with lib; {

  };
}