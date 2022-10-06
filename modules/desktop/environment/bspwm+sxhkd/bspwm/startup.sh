. get_active_monitors >> /dev/null

for monitor in ${C_ACTIVE_MONITORS[@]}; do
  if [ "$monitor" = "DP-1" ]; then 
    xrandr --output "DP-1" --primary
    # xrandr --output "eDP-1" --same-as "DP-1"
    xrandr --output "DP-1" --right-of "eDP-1"
    break
  fi
done
