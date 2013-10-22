#
# Some settings to always use Nvidia GPU in X.
#

# Set video calculation on Nvidia GPU, but as output use integrated Intel card.
xrandr --setprovideroutputsource 0x44 0x2b2

# Don't need on my situation
#xrandr --output LVDS-0 --off

xrandr --auto

# Run xmonad
xmonad
