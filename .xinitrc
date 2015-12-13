#
# Some settings to always use Nvidia GPU in X.
#

# Set video calculation on Nvidia GPU, but as output use integrated Intel card.
#xrandr --listproviders
xrandr --setprovideroutputsource 0x44 0x2b3
#xrandr --setprovideroutputsource 0x279 0x2b2

# Don't need on my situation
#xrandr --output LVDS-0 --off

xrandr --auto

# Compise!
#xcompmgr -cC -fF &

# Run xmonad
xmonad

#startfluxbox

#startkde
