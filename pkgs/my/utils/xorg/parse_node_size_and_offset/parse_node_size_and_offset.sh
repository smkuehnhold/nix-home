# Parses a string like '900x600+2159+419' (WxH+X+Y) and returns each number separated by a newline
# Strings like this appear to show up often in xorg-related commands, so this is a common implementation
# "Node" might not be an X-ism. The concept is stolen from BSPWM and refers to any visual subunit in a standard x-session
#   (i.e. display, monitor, window)

NODE_SIZE_AND_OFFSET="$1"

NODE_SIZE="$(echo "$NODE_SIZE_AND_OFFSET" | cut --delimiter="+" --fields=1)"
NODE_WIDTH="$(echo "$NODE_SIZE" | cut --delimiter="x" --fields=1)"
NODE_HEIGHT="$(echo "$NODE_SIZE" | cut --delimiter="x" --fields=2)"

NODE_OFFSET="$(echo "$NODE_SIZE_AND_OFFSET" | cut --delimiter="+" --fields=2-)"
NODE_X_OFFSET="$(echo "$NODE_OFFSET" | cut --delimiter="+" --fields=1)"
NODE_Y_OFFSET="$(echo "$NODE_OFFSET" | cut --delimiter="+" --fields=2)"

printf "\
%s
%s
%s
%s\
" "$NODE_WIDTH" "$NODE_HEIGHT" "$NODE_X_OFFSET" "$NODE_Y_OFFSET"