# Deletes the largest numbered desktop on the current monitor if it is greater than SMALLEST_DESKTOP_NAME + LOWER_BOUND
# The only arg is the LOWER_BOUND

LOWER_BOUND="$1"

CURRENT_SMALLEST="$(get-smallest-desktop-name)"
CURRENT_LARGEST="$(get-largest-desktop-name)"

if test "$CURRENT_LARGEST" -ge $((CURRENT_SMALLEST+LOWER_BOUND)); then
    bspc desktop "$CURRENT_LARGEST" --remove
fi