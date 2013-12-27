#!/bin/sh
#
# Delete comments and empty lines from input file.
#

if [ -z $1 ] || ! [ -r $1 ]; then
	echo Usage: $0 filename
	return 0;
fi

sed -e s/#.*$// -e /^$/d $1 | sort
