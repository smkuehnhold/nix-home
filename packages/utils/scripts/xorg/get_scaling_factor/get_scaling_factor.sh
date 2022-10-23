DPI="$(xrdb -query | grep "^Xft.dpi" | cut -f 2)"

if test -z "$DPI"; then
    SCALING_FACTOR=1
else
    SCALING_FACTOR="$(("$DPI" / 96))"
fi

echo "$SCALING_FACTOR"
