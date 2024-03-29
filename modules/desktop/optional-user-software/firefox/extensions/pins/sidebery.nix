{ pkgs, lib, ... }:

# pkgs.fetchFirefoxAddon {
#   name = "sidebery";
#   url = "https://addons.mozilla.org/firefox/downloads/file/3994928/sidebery-4.10.2.xpi";
#   sha256 = "60e35f2bfac88e5b2b4e044722dde49b4ed0eca9e9216f3d67dafdd9948273ac";
# }

# https://github.com/nix-community/nur-combined/blob/281c1567bf5e3a62b25a3c703f074f12dcd31e96/repos/rycee/pkgs/firefox-addons/generated-firefox-addons.nix#L6735
pkgs.my.lib.buildFirefoxXpiAddon {
  pname = "sidebery";
  version = "4.10.2";
  addonId = "{3c078156-979c-498b-8990-85f7987dd929}";
  url = "https://addons.mozilla.org/firefox/downloads/file/3994928/sidebery-4.10.2.xpi";
  sha256 = "60e35f2bfac88e5b2b4e044722dde49b4ed0eca9e9216f3d67dafdd9948273ac";
  meta = with lib; {
    homepage = "https://github.com/mbnuqw/sidebery";
    description = "Tabs tree and bookmarks in sidebar with advanced containers configuration.";
    license = licenses.mit;
    mozPermissions = [
      "tabs"
      "contextualIdentities"
      "cookies"
      "storage"
      "bookmarks"
      "sessions"
      "menus"
      "menus.overrideContext"
      "search"
      ];
    platforms = platforms.all;
  };
}