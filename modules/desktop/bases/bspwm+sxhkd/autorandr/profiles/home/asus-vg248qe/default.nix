{ mkAutorandrMonitor, ... }:

mkAutorandrMonitor {
  port = "DP-3";

  fingerprint = ./fingerprint;

  enable = true;
  mode = "1920x1080";
  rate = "144.0";
  position = "0x1080";
  primary = true;
}