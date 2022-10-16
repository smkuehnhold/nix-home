DPI="$(xrdb -query Xft.dpi | cut -f 2)"
SCALING_FACTOR="$(( "$DPI" / 96))"

echo "$SCALING_FACTOR"
