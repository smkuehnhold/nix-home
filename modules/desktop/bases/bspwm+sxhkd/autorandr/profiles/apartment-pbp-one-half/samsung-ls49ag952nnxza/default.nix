{ mkAutorandrMonitor, ... }:

mkAutorandrMonitor {
  port = "DP-1";

  fingerprint = ./fingerprint;

  enable = true;
  mode = "2560x1440";
  rate = "120";
  position = "0x0";
  primary = true;
}