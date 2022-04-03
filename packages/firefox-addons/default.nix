{ nur, lib, ... }:

let
  inherit (nur.repos.rycee.firefox-addons) buildFirefoxXpiAddon;
in {
  vpnAC = buildFirefoxXpiAddon {
    pname = "vpnAC-secure-proxy";
    version = "2.4.0";
    addonId = "jid1-ghu2YUV0nwAoAg@jetpack";
    url = "https://vpn.ac/download/secureproxy.xpi";
    sha256 = "a3zYu6EZpH1KipgxXIFpGbXVFc904HxK9SplNAkn+mg=";
    meta = with lib; {
      homepage = "https://vpn.ac";
      description = "A web proxy for the VPN.AC service";
      platforms = platforms.all;
    };
  }; 
}
