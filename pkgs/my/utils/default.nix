{ callPackage, ... }:

{
  bspwm = callPackage ./bspwm {};
  math = callPackage ./math {};
  xorg = callPackage ./xorg {};
}