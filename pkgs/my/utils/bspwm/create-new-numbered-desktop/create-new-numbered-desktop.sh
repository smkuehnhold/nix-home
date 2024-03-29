# Creates a new desktop on the current monitor with name = largest numerical name of current desktops + 1

CURRENT_LARGEST="$(get-largest-desktop-name)"

bspc monitor --add-desktops $((CURRENT_LARGEST+1))