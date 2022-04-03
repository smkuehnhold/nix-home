# Inspired from
# https://github.com/amayer5125/nord-rofi


{ config, pkgs, lib, ... }:

let
  inherit (config.lib.formats.rasi) mkLiteral;
  getBin = pkg: "${pkg}/bin/${lib.getName pkg}";
in {
  home.packages = with pkgs; [ jost ];

  programs.rofi = {
    enable = true;

    font = "Jost*:style=Book,Regular 20";
    
    terminal = (getBin config.my.home.terminal);

    location = "bottom";

    theme = {

      "*" = {
  #      "background-color" = mkLiteral colorScheme.nord1;
	"border" = mkLiteral "0px";
	"margin" = mkLiteral "0px";
	"padding" = mkLiteral "0px";
	"spacing" = mkLiteral "0px";
  #      "text-color" = mkLiteral colorScheme.nord4;
      };

      # necessasry modification to invert listview and input bar (when on bottom of screen)
      "#window" = {
	"anchor" = "south";
	"children" = builtins.map mkLiteral ["listview" "inputbar"];
      };

      "#inputbar" = {
  #      "text-color" = mkLiteral colorScheme.nord3;
	"padding" = mkLiteral "6px";
	"margin" = mkLiteral "0px 0px 2px";
	"children" = builtins.map mkLiteral ["entry"];
      };

      "#entry" = {
  #      "background-color" = mkLiteral colorScheme.nord3;
  #      "text-color" = mkLiteral colorScheme.nord4;
	"padding" = mkLiteral "5px";
      };

      "#message" = {
	"border" = mkLiteral "0px 0px 1px";
  #      "border-color" = mkLiteral colorScheme.nord3;
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
  #      "text-color" = mkLiteral colorScheme.nord4;
      };

  #    "#element.normal.normal" = {
  #      "text-color" = mkLiteral colorScheme.nord4;
  #    };

  #    "#element.normal.urgent" = {
  #      "text-color" = mkLiteral colorScheme.nord11;
  #    };

  #    "#element.normal.active" = {
  #      "text-color" = mkLiteral colorScheme.nord10;
  #    };

  #    "#element.alternate.normal" = {
  #      "text-color" = mkLiteral colorScheme.nord4;
  #    };

  #    "#element.alternate.urgent" = {
  #      "text-color" = mkLiteral colorScheme.nord11;
  #    };

  #    "#element.alternate.active" = {
  #     "text-color" = mkLiteral colorScheme.nord10;
  #    };

  #   "#element.selected.normal" = {
  #     "background-color" = mkLiteral colorScheme.nord8;
  #     "text-color" = mkLiteral colorScheme.nord1;
  #   };

  #   "#element.selected.urgent" = {
  #     "background-color" = mkLiteral colorScheme.nord11;
  #     "text-color" = mkLiteral colorScheme.nord4;
  #   };

  #   "#element.selected.active" = {
  #     "background-color" = mkLiteral colorScheme.nord10;
  #     "text-color" = mkLiteral colorScheme.nord4;
  #   };

      "#scrollbar" = {
  #     "handle-color" = mkLiteral colorScheme.nord3;
	"handle-width" = mkLiteral "0.50em";
      };

  #   "#button.selected" = {
  #     "background-color" = mkLiteral colorScheme.nord8;
  #     "text-color" = mkLiteral colorScheme.nord4;
  #   };
    };
  };
}
