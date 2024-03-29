{ mkAutorandrMonitor, ... }:

mkAutorandrMonitor {
  port = "DP-1";

  fingerprint = ./fingerprint;

  enable = true;
  mode = "5120x1440";
  rate = "239.76";
  position = "0x0";
  primary = true;
}