# Moves focused window to one or more edges of its monitor if it is floating
# ARGS:
#   -t TOP
#   -l LEFT
#   -b BOTTOM
#   -r RIGHT

NODE_TO_MOVE="$(bspc query --nodes --desktop .focused --node .focused.floating)"

if test -z "$NODE_TO_MOVE"; then
    # Focused node is not floating
    exit 1
fi

OPTSTRING=":tlbr"

FOCUSED_MONITOR="$(get-focused-monitor-name)"
FOCUSED_MONITOR_SIZE="$(get_monitor_size "$FOCUSED_MONITOR")"
FOCUSED_MONITOR_WIDTH="$(echo "$FOCUSED_MONITOR_SIZE" | head -n 1)"
FOCUSED_MONITOR_HEIGHT="$(echo "$FOCUSED_MONITOR_SIZE" | tail -n +2 | head -n 1)"

NODE_SIZE_AND_OFFSET="$(get_window_size_and_offset "$NODE_TO_MOVE")"
NODE_WIDTH="$(echo "$NODE_SIZE_AND_OFFSET" | head -n 1)"
NODE_HEIGHT="$(echo "$NODE_SIZE_AND_OFFSET" | tail -n +2 | head -n 1)"
NODE_X_OFFSET="$(echo "$NODE_SIZE_AND_OFFSET" | tail -n +3 | head -n 1)"
NODE_Y_OFFSET="$(echo "$NODE_SIZE_AND_OFFSET" | tail -n +4 | head -n 1)"

while getopts "$OPTSTRING" opt; do
    DELTA_X=0
    DELTA_Y=0

    case "$opt" in
        t)
            DELTA_Y=$((0-NODE_Y_OFFSET))
            ;;
        l)
            DELTA_X=$((0-NODE_X_OFFSET))
            ;;
        b)
            DELTA_Y=$((FOCUSED_MONITOR_HEIGHT-NODE_Y_OFFSET-NODE_HEIGHT))
            ;;
        r)
            DELTA_X=$((FOCUSED_MONITOR_WIDTH-NODE_X_OFFSET-NODE_WIDTH))
            ;;
    esac

    bspc node "$NODE_TO_MOVE" --move "$DELTA_X" "$DELTA_Y"
done