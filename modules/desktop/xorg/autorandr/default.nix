{ ... }:

{
  programs.autorandr.enable = true;
  xsession.initExtra = ''
    # Detect and load appropriate configuration at init
    autorandr -c
  '';
}