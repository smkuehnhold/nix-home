MONITOR_PREDICATE="$1"

read -a MONITORS <<< "$(get_active_monitors.sh)"
for monitor in "${MONITORS[@]}"; do
  if [[ "$monitor" == "$MONITOR_PREDICATE" ]]; then
    echo true
    exit
  fi    
done
echo false
