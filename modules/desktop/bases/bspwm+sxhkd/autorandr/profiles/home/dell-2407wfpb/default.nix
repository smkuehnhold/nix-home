{ mkAutorandrMonitor, ... }:

mkAutorandrMonitor {
  port = "HDMI-1";

  fingerprint = ./fingerprint;

  enable = true;
  mode = "1920x1200";
  rate = "59.95";
  position = "1920x1080";
}