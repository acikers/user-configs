#
# Some settings to always use Nvidia GPU in X.
#

# Set video calculation on Nvidia GPU, but as output use integrated Intel card.
#xrandr --listproviders
xrandr --setprovideroutputsource modesetting NVIDIA-0
xrandr --auto

# Compise!
#xcompmgr -cC -fF &

# Run xmonad
xmonad

#startfluxbox

#startkde
