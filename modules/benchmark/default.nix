{ pkgs, ... }:

{
  home.packages = with pkgs; [ 
   (steam.override {
     extraLibraries = (pkgs: with pkgs; [ libxml2 curl (php.withExtensions ({ enabled, all}: enabled ++ [all.dom all.ldap all.curl])) ] );
   }).run
   phoronix-test-suite
  ];
}
