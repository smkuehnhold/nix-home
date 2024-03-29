{ mkAutorandrMonitor, ... }:

mkAutorandrMonitor {
  port = "DP-2";

  fingerprint = ./fingerprint;

  enable = true;
  mode = "1920x1080";
  rate = "60.0";
  position = "1920x0";
}