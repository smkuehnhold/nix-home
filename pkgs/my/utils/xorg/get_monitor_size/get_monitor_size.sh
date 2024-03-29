OUTPUT="$1"

OUTPUT_SIZE_AND_OFFSET="$(xrandr -q | grep "$OUTPUT " | cut --delimiter=" " --fields=4)"

if test -z "$OUTPUT_SIZE_AND_OFFSET"; then
    # Output doesn't exist
    exit 1
fi

parse_node_size_and_offset "$OUTPUT_SIZE_AND_OFFSET" | head -n 2