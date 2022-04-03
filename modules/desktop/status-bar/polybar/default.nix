{ pkgs, ... }:
let
  fonts = import ./fonts { inherit pkgs; };
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
  cut = "${pkgs.coreutils}/bin/cut";
  grep = "${pkgs.gnugrep}/bin/grep";
in {
  home.packages = with pkgs; with fonts; [ jost typicons font-awesome ];

  services.polybar = {
    enable = true;

    settings = {
      "module/pager" = {
        type = "internal/bspwm";
        enable-scroll = false;

        label = {
          focused = {
            text = "";
            padding = 1;
            foreground = "#FFFFFF";
            font = 3;
          };
          
          occupied = {
            text = "";
            padding = 1;
            foreground = "#FFFFFF";
            font = 4;
          };

          urgent = {
            text = "";
            padding = 1;
            foreground = "#FFFFFF"; 
            font = 4;
          };

          empty = {
            text = "";
            padding = 1;
            foreground = "#FFFFFF";
            font = 4;
          };
        };
      };

      "module/time" = {
        type = "internal/date";

        time = "%I:%M %p";

        label = {
          text = "%time%";
          padding = 1;
          foreground = "#FFFFFF";
        };
      };

      "module/date" = {
        type = "internal/date";

        date = "%a, %b %d, %Y";

        label = {
          text = "%date%";
          padding = 1;
          foreground = "#FFFFFF";
        };
      };

      "bar/top" = {
        wm-restack = "bspwm";

        monitor = "\${env:MONITOR}";

        font = [ 
          "Jost*:style=Book,Regular:pixelsize=20;1" 
          "typicons:style=Regular:pixelsize=26"
          "Font Awesome 5 Free,Font Awesome 5 Free Solid:style=Solid:pixelsize=16;1"
          "Font Awesome 5 Free,Font Awesome 5 Free Regular:style=Regular:pixelsize=16;1"
        ];

        height = "1.75%";
        width = "99.7%";
        offset.x = "0.15%";

        modules = {
          left = "pager";
          center = "date";
          right = "time";
          margins = {
            left = "1.25%";
            center = "1.25%";
            right = "1.25%";
          };
        }; 
      };
    };
   
   script = ''
     CONNECTED_MONITORS=$(${xrandr} -q | ${grep} -w "connected" | ${cut} -d " " -f1)

     is_connected () {
       local __var=$1
       local mon_is_con=$(echo $CONNECTED_MONITORS | ${grep} -c $2)
       eval $__var=$mon_is_con
     }

     is_connected EDP_IS_CONNECTED "eDP-1"

     if [ $EDP_IS_CONNECTED -eq 1 ]; then
       MONITOR="eDP-1" polybar top &
     fi
   '';
  };
}
