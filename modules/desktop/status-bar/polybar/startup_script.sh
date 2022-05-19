. get_active_monitors &>/dev/null

for monitor in "${C_ACTIVE_MONITORS[@]}"; do
  if [ $monitor = "eDP-1" ]; then
    MONITOR="$monitor" polybar top &
  else
    MONITOR="$monitor" polybar top-desktop &
  fi
done
