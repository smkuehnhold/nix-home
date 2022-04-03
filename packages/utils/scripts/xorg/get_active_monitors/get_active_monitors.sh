XRANDR_OUTPUT="$(xrandr --listmonitors | tail -n +2 | cut -c 2-)"

IFS=$'\n' read -d '' -a UNFILTERED_MONITORS <<< $XRANDR_OUTPUT

declare -a C_ACTIVE_MONITORS
for unfiltered_monitor in "${UNFILTERED_MONITORS[@]}"; do
  C_ACTIVE_MONITORS[${#C_ACTIVE_MONITORS[@]}]="$(echo "$unfiltered_monitor" | cut -d ' ' -f 2 | cut -c 3-)"
done

echo "${C_ACTIVE_MONITORS[@]}"
