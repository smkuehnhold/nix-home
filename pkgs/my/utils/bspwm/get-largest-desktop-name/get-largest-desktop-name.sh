# Gets the largest desktop name on the current monitor
# In my current config, monitor names are always numbers

bspc query --desktops --names | sort -n -r | head -n 1