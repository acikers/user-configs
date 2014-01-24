#!/bin/bash
# Script for make devices from devfs.
# As input use output from "ls -la /dev/"
# TODO: directories!

first_char=-1
minor=-1
major=-1
while read p; do
	first_char=${p:0:1};
	if [ $first_char = "c" ] || [ $first_char = "b" ] ; then
		major=`echo $p | cut -d \  -f 5 | sed -e s/,//`
		minor=`echo $p | cut -d \  -f 6`
		name=`echo $p | cut -d \  -f 10`
		mode=0
		for i in 1 2 3
		do
			if [ ${p:$((i*3-2)):1} = 'r' ] ; then
				mode=$(($mode+4))
			fi
			if [ ${p:$((i*3-1)):1} = 'w' ] ; then
				mode=$((mode+2))
			fi
			if [ ${p:$((i*3)):1} = 'x' ] ; then
				mode=$((mode+1))
			fi
			mode=$((mode*10))
		done
		mode=$((mode/10))
		mknod -m $mode $name $first_char $major $minor
	elif [ $first_char = "d" ]; then
		echo Directory!
	elif [ $first_char = "l" ]; then
		name=`echo $p | cut -d \  -f 9`
		target=`echo $p | cut -d \  -f 11`
		ln -s $target $name
	elif [ $first_char = "s" ]; then
		echo "Socket!"
  fi
done;
