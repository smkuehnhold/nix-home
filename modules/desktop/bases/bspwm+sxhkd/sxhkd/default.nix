{ lib, config, pkgs, ... }:
let
  numbers = pkgs.my.utils.math;

  # Not sure if there is a library function that accomplishes the same thing
  #  lib.getBin does not seem to do what I think it should do
  getBin = pkg: "${pkg}/bin/${lib.getName pkg}";
  # FIXME: At some point, might want a smarter way to select a sink
  commands = with config; {
    terminal = "${getBin pkgs.alacritty}"; # FIXME: What if I change terminals??
    launcher = "${getBin pkgs.rofi}";
    bspc = "${pkgs.bspwm}/bin/bspc"; 
    sed = "${pkgs.gnused}/bin/sed";
    awk = "${pkgs.gawk}/bin/awk";
    notifySend = "${pkgs.libnotify}/bin/notify-send";
    autorandr = "${pkgs.autorandr}/bin/autorandr";
    createNewNumberedDesktop = "${pkgs.my.utils.bspwm.createNewNumberedDesktop}/bin/create-new-numbered-desktop";
    deleteLargestNumberedDesktopGreaterThanLowerBound = "${pkgs.my.utils.bspwm.deleteLargestNumberedDesktopGreaterThanLowerBound}/bin/delete-largest-numbered-desktop-greater-than-lower-bound";
    moveFloatingNodeToEdge = "${pkgs.my.utils.bspwm.moveFloatingNodeToEdge}/bin/move-floating-node-to-edge";
    pamixer = let 
      cmd = getBin pkgs.pamixer;
    in rec {
      volume = rec { 
        setRaw = pct: "${unmute}; ${cmd} --set-volume ${pct}";
        get = "${cmd} --get-volume";
        increment = pct: "volume=$(${get}); ${setRaw "$(${numbers.raiseToNextMultiple} ${pct} $volume)"}";
        decrement = pct: "volume=$(${get}); ${setRaw "$(${numbers.lowerToNextMultiple} ${pct} $volume)"}";
      };   	
      mute = "${cmd} --mute";
      unmute = "${cmd} --unmute";
      toggleMute = "${cmd} --toggle-mute";
    };
    light = let
      cmd = getBin pkgs.light;
    in {
      brightness = rec {
        get = "${cmd} -G"; 
        setRaw = pct: "${cmd} -S ${pct}";
        increment = pct: "brightness=$(${get}); ${setRaw "$(${numbers.raiseToNextMultiple} ${pct} $brightness)"}";
        decrement = pct: "brightness=$(${get}); ${setRaw "$(${numbers.lowerToNextMultiple} ${pct} $brightness)"}";
        # Note: Might want to be careful with these, 0 seems to REALLY mean 0
        # light lets you set an absolute minumum with -P, which I currently have to 20
        # in an emergency, might want to look into kernelParam i915.invert_brightness=1
        # also maybe create a custom system-d module which sets the brightness to 20 upon boot if below 20?
        setToMax = "${cmd} -S 100";
        setToMin = "${cmd} -S 0";
      };
    };
  };
in {
  services.sxhkd = {
    enable = true;
    keybindings = with commands; {
      # quit bspwm 
      "super + shift + q" = "${bspc} quit"; 

      # load detected autorandr profile
      #  (restarts bspwm among other things)
      "super + shift + r" = "${autorandr} -c";

      # reload sxhkd config
      "super + shift + z" = "pkill -10 sxhkd";

      # close OR kill window rooted at selected node
      "super + {_,shift + }w" = "${bspc} node -{c,k}";  

      # launch the default terminal
      "super + Return" = "${terminal}";

      # launch the default launcher
      #   modes:
      #     (drun): shows available *desktop applications*. selection launches instance of selected program
      #     (windowcd): shows open windows. selection switches focus to selected window
      # FIXME: Maybe should rethink if I want to support different launchers. This hardcodes rofi...
      "super + {_,alt +} space" = "${launcher} -show {drun,windowcd}";

      # (bspc desktop -f DESKTOP_NAME): focusus on desktop with name DESKTOP_NAME
      # (bspc node -d DESKTOP_NAME): sends focused node to desktop with name DESKTOP_NAME
      # (bspc query -D -m focused --names): queries for desktops on the currently focused monitor and prints their names
      # (sed "#q;d"): filters and prints the string on line numbaaaer #
      # i.e. focus on the nth desktop owned by the currently focused monitor OR
      #      send the currently focused norfe to the nth desktop owned by the currently focused monitor
      "super + {_, shift +}{1-9}" = "${bspc} {desktop -f,node -d} $(${bspc} query -D -m focused --names | ${sed} \"{1-9}q;d\")";
      "super + {_, shift +}grave" = "${bspc} {desktop -f,node -d} last";
      "super + alt + {1,2}; {_, shift +}{1-9}" = ''
        DESKTOPS={"1 2 3 4","5 6 7 8"}; COMMAND={"desktop -f","node -d"}; \
         ${bspc} $COMMAND $(echo "$DESKTOPS" | cut -d" " -f{1-9})
        '';

      # FIXME: Clean-up
      # Do the same thing as above, but absolutely
      #"super + a + {1-9}: {_, shift +}{1-9}" = "DESKTOPS={\"1 2 3 4\",\"5 6 7 8\",\"\",\"\",\"\",\"\",\"\",\"\",\"\"}; ${bspc} {desktop -f,node -d} \$(echo \"$DESKTOPS\" | cut -d\" \" -f{1-9})";
      #"super + a + {_, shift +}{1-9}" = "${bspc} {desktop -f, node -d} {1-9}";
      # "super + o; {1,2} + {_, shift +}{1-9}" = ''
      #   DESKTOPS={"1 2 3 4","5 6 7 8"}; COMMAND={"desktop -f","node -d"}; \
      #    ${bspc} $COMMAND $(echo "$DESKTOPS" | cut -d" " -f{1-9})
      # '';

      # Media-keys
      "XF86AudioMute" = pamixer.toggleMute;
      "XF86AudioLowerVolume" = pamixer.volume.decrement (toString 5);
      "super + XF86AudioLowerVolume" = pamixer.volume.setRaw (toString 0);
      "XF86AudioRaiseVolume" = pamixer.volume.increment (toString 5);
      "super + XF86AudioRaiseVolume" = pamixer.volume.setRaw (toString 100);
       
      "XF86MonBrightnessDown" = light.brightness.decrement(toString 5);
      "super + XF86MonBrightnessDown" = light.brightness.setToMin;
      "XF86MonBrightnessUp" = light.brightness.increment(toString 5);
      "super + XF86MonBrightnessUp" = light.brightness.setToMax;

      # Resize windows
      # NOTE: ":" rather than ";" seperating chord enters "mode" (you don't have to repeat the first chord for subsequent commands. Hit ESC to exit "mode)
      # NOTE: Extra spacing on subsequent lines is to handle to wierd interaction between nix multiline-strings and the sxhkd module.
      # https://www.reddit.com/r/bspwm/comments/r5stxu/resizing_windows_nicely_in_my_opinion/hmu0gsw/
      "super + s: {h,j,k,l}" = ''
        STEP=20; SELECTION={1,2,3,4}; \
         bspc node --resize $(echo "left -$STEP 0,bottom 0 $STEP,top 0 -$STEP,right $STEP 0" | cut -d',' -f$SELECTION) || \
         bspc node --resize $(echo "right -$STEP 0,top 0 $STEP,bottom 0 -$STEP,left $STEP 0" | cut -d',' -f$SELECTION)
      '';

      # Move windows
      "super + s: shift + {h,j,k,l}" = ''
        STEP=20; COORD={"-$STEP 0","0 $STEP","0 -$STEP","$STEP 0"}; \
          bspc node --move $COORD
      '';

      # Set window state
      # NOTE: ~ reverts to previous state if node is actually in the state
      "super + s: {t,shift + t,p,shift + p,f,shift+f,u,shift + u}" = ''
        bspc node --state {tiled,~tiled,pseudo_tiled,~pseudo_tiled,floating,~floating,fullscreen,~fullscreen}	
      '';

      # Move a floating node to the edge of its monitor
      "super + s: ctrl + {h,j,k,l}" = "${commands.moveFloatingNodeToEdge} {-l,-b,-t,-r}";

      # Cycle between windows on the current desktop
      "super + {c,shift + c}" = "bspc node --focus {next,prev}.local.window";

      # Cycle desktop between monocle and tiled layouts
      "super + m" = "bspc desktop --layout next";

      # Toggle the bottom bar
      # FIXME: What if I don't want to padding to be 0 by default?
      "super + b" = "bspc config bottom_padding 0 && polybar-msg cmd toggle";

      # Create a new desktop with name = largest name on current desktop + 1
      "super + {_, shift +} d" = "{${commands.createNewNumberedDesktop},${commands.deleteLargestNumberedDesktopGreaterThanLowerBound} 4}";
    }; 
  };
}
