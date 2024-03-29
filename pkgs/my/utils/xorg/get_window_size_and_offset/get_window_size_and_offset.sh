# Prints the size and offset of the window pointed to by WINDOW_ID
WINDOW_ID="$1"

WINDOW_INFO="$(xwininfo -id "$WINDOW_ID")"

# --fields=4 because xwinifo | grep geometry returns a string that starts with 3 spaces
WINDOW_SIZE_AND_OFFSET_RAW="$(xwininfo -id "$WINDOW_ID" | grep "geometry" | cut --delimiter=" " --fields=4)"
WINDOW_SIZE_AND_OFFSET="$(parse_node_size_and_offset "$WINDOW_SIZE_AND_OFFSET_RAW")"
WINDOW_WIDTH="$(echo "$WINDOW_SIZE_AND_OFFSET" | head -n 1)"
WINDOW_HEIGHT="$(echo "$WINDOW_SIZE_AND_OFFSET" | tail -n +2 | head -n 1)"

# Ignore the offsets because xwinfo reports them as negative and relative to the right edge sometimes for some reason
# --fields=N because xwininfo adds unnecessary spaces
WINDOW_X_OFFSET="$(echo "$WINDOW_INFO" | grep "Relative upper-left X" | cut --delimiter=" " --fields=7)"
WINDOW_Y_OFFSET="$(echo "$WINDOW_INFO" | grep "Relative upper-left Y" | cut --delimiter=" " --fields=7)"

printf "\
%s
%s
%s
%s\
" "$WINDOW_WIDTH" "$WINDOW_HEIGHT" "$WINDOW_X_OFFSET" "$WINDOW_Y_OFFSET"