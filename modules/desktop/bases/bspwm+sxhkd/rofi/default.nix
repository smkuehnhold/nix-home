{ lib, config, pkgs, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
  getBin = pkg: "${pkg}/bin/${lib.getName pkg}";
in {
  home.packages = with pkgs; [ jost ];

  programs.rofi = {
    enable = true;

    font = "Jost*:style=Book,Regular 20";

    location = "bottom";

    theme = {
      "*" = {
        "border" = mkLiteral "0px";
        "margin" = mkLiteral "0px";
        "padding" = mkLiteral "0px";
        "spacing" = mkLiteral "0px";
      };

      "#window" = {
        "anchor" = "south";
        "children" = builtins.map mkLiteral ["listview" "inputbar"];
      };

      "#inputbar" = {
        "padding" = mkLiteral "6px";
        "margin" = mkLiteral "0px 0px 2px";
        "children" = builtins.map mkLiteral ["entry"];
      };

      "#entry" = {
        "padding" = mkLiteral "5px";
      };

      "#message" = {
        "border" = mkLiteral "0px 0px 1px";

        "padding" = mkLiteral "0px 0px 6px 7px";
      };

      "#listview" = {
        "lines" = 10;
        "padding" = mkLiteral "2px 0px 0px";
        "scrollbar" = true;
        "reverse" = true;
      };

      "#element" = {
        "padding" = mkLiteral "0px 0px 0px 7px";
        "margin" = mkLiteral "0px 0px 5px 0px";
      };

      "#scrollbar" = {
        "handle-width" = mkLiteral "0.50em";
      };
    };
  };
}
