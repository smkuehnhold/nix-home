{ callPackage, ... }:

{
  math = (callPackage ./math {});
  xorg = (callPackage ./xorg {}); 
}
