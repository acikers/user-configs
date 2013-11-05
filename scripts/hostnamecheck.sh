#!/bin/bash
#
# Script for checkout between branches bases on hostname.
#


# Get branch list
BRANCHES=(`git branch -r | awk -F '/' '{print $2}' | sed -e /HEAD/d`)
#BRANCHES="master HEAD less more darwish fuck off you sucker"

# Find branchname equal to current hostname
for i in $BRANCHES; do
	if [ $i == $HOSTNAME ]; then
		found=true
		break
	fi
done

# So... final
if [ $found ]; then
	echo "Checkouting to branch $i"
	git checkout `git remote`/$i
else
	echo "Couldn't find any branch for current hostname"
	echo "Just use what you want!"
fi
