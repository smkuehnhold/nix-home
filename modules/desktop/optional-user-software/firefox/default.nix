{ pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    profiles = {
      default = {
        isDefault = true;
        extensions = import ./extensions { inherit pkgs; };
        settings = {
          "signon.rememberSignons" = false;
          "dom.security.https_only_mode" = true;
          "media.ffmpeg.vaapi-drm-display.enabled" = true;
          "browser.toolbars.bookmarks.2h2020" = false;
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        userChrome = ''
          #TabsToolbar { visibility: collapse !important; }
          #sidebar-box[sidebarcommand="_3c078156-979c-498b-8990-85f7987dd929_-sidebar-action"] #sidebar-header {
            display: none !important;
          }
        '';
      };
    };
  };
}
