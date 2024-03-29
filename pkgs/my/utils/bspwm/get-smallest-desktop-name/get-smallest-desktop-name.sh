# Gets the smallest desktop name on the current monitor
# In my current config, monitor names are always numbers

bspc query --desktops --names | sort -n | head -n 1