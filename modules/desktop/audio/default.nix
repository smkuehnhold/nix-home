{ pkgs, ... }:

{
  # FIXME: At some point, I want a native pipewire cli client...
  home.packages = with pkgs; [ pamixer pulseaudio ];

  # FIXME: Pipewire is borked after startup for some reason
  xsession.initExtra = ''
    systemctl --user restart pipewire
  '';
}
