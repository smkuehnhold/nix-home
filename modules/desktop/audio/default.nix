{ pkgs, ... }:

{
  # FIXME: At some point, I want a native pipewire cli client...
  home.packages = with pkgs; [ pamixer pulseaudio ];
}
