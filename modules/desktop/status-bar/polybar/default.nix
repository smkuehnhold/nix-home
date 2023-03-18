{ pkgs, ... }:
let
  fonts = import ./fonts { inherit pkgs; };
  inherit (pkgs) my;
in {
  home.packages = with pkgs; with fonts; [ jost font-awesome_5 ];

  # FIXME: What about other desktop environments?
  # initExtra does not work because it occurs before bspwm starts
  xsession.windowManager.bspwm.extraConfig = ''
    systemctl --user restart polybar.service
  '';

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

      # Seems like every bar needs a module??
      "module/null" = {
        type = "custom/text";
        content = " ";
      };

      "module/wireless-network" = {
        type = "internal/network";

        interface = "wlan0";

        format = {
          connected = "<label-connected> <ramp-signal>";
          disconnected = "";
        };

        label.connected = {
          text = "%essid%";
          foreground = "#FFFFFF";
        };

        ramp.signal = [
          {
            text = "";
            font = 3;
            foreground = "#FFFFFF";
          }
        ];
      };

      "module/wired-network" = {
        type = "internal/network";

        interface = "enp137s0u1";

        format = {
          connected = "<label-connected> <ramp-signal>";
          disconnected = "";
        };

        label.connected = {
          text = "%ifname%";
          foreground = "#FFFFFF";
        };

        ramp.signal = [
          {
            text = "";
            font = 3;
            foreground = "#FFFFFF";
          }
        ];
      };

      # stolen from:
      # https://github.com/jonringer/nixpkgs-config/blob/a0f7694412e269c1c26db91a1c4cda87e3242a53/polybar-config#L226
      "module/pipewire" = let
        polybarPipewire = "${my.lib.writeShellScriptBin {
          name = "polybar-pipewire";
          text = builtins.readFile ./polybar-pipewire.sh;
          runtimeInputs = with pkgs; [
            coreutils gnused pamixer pulseaudio pipewire
          ];
        }}/bin/polybar-pipewire";
      in{
        type = "custom/script";
        interval = "1.0";

        label = {
          text = "%output% ";
        };

        exec = polybarPipewire;

        click = {
          # right = "exec pavucontrol &";
          left = "${polybarPipewire} mute &";
        };

        scroll = {
          up = "${polybarPipewire} up &";
          down = "${polybarPipewire} down &";
        };

      };

      "module/battery" = {
        type = "internal/battery";

        adapter = "ACAD";
        battery = "BAT1";

        #poll.interval = 0;

        label.charging = {
          text = "%percentage%%";
          foreground = "#FFFFFF";
        };

        label.discharging = {
          text = "%percentage%%";
          foreground = "#FFFFFF";
        };

        ramp.capacity = [
          {
            text = "";
            font = 3;
            foreground = "#FFFFFF";
          }
        ];

        format = {
          # FIXME
          # For some reason, framework power suppy always reports discharging, which is unfortunate...
          # See `cat /sys/class/power_supply/BAT1/status`
          charging = "<label-charging> <ramp-capacity>";
          discharging = "<label-discharging>";
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

        module.margin = 1;

        modules = {
          left = "pager";
          center = "date";
          right = "time";
        }; 
      };

      "bar/top-desktop" = {
        wm-restack = "bspwm";

        monitor = "\${env:MONITOR}";

        font = [ 
          "Jost*:style=Book,Regular:pixelsize=15;1" 
          "typicons:style=Regular:pixelsize=21"
          "Font Awesome 5 Free,Font Awesome 5 Free Solid:style=Solid:pixelsize=12;1"
          "Font Awesome 5 Free,Font Awesome 5 Free Regular:style=Regular:pixelsize=12;1"
        ];

        height = "1.75%";
        width = "99.7%";
        offset.x = "0.15%";

        module.margin = 1;

        modules = {
          left = "pager";
          center = "date";
          right = "time";
        }; 
      };

      "bar/bottom" = {
        wm-restack = "bspwm";

        monitor = "\${env:MONITOR}";

        bottom = true;
        # Gives us the ability to call polybar-msg cmd toggle
        enable.ipc = true;

        font = [ 
          "Jost*:style=Book,Regular:pixelsize=20;1" 
          "typicons:style=Regular:pixelsize=26"
          "Font Awesome 5 Free,Font Awesome 5 Free Solid:style=Solid:pixelsize=16;1"
          "Font Awesome 5 Free,Font Awesome 5 Free Regular:style=Regular:pixelsize=16;1"
        ];

        tray.position = "left";

        height = "1.75%";
        width = "99.7%";
        offset.x = "0.15%";

        module.margin = 1;

        modules = {
          right = "wireless-network wired-network battery";
        }; 
      };

      "bar/bottom-desktop" = {
        wm-restack = "bspwm";

        monitor = "\${env:MONITOR}";

        bottom = true;
        enable.ipc = true;

        font = [ 
          "Jost*:style=Book,Regular:pixelsize=15;1" 
          "typicons:style=Regular:pixelsize=21"
          "Font Awesome 5 Free,Font Awesome 5 Free Solid:style=Solid:pixelsize=12;1"
          "Font Awesome 5 Free,Font Awesome 5 Free Regular:style=Regular:pixelsize=12;1"
        ];

        tray = {
          position = "left";
          offset.x = "0.15%";
        }; 

        height = "1.75%";
        width = "99.7%";
        offset.x = "0.15%";

        module.margin = 1;

        modules = {
          right = "wireless-network wired-network battery";
        }; 
      };
    };

    script = my.lib.readScript { 
      path = ./startup-script.sh;
      runtimeInputs = [ my.packages.utils.scripts.xorg.getActiveMonitors ]; 
    };
  };
}
