#!/bin/bash

WORDS=$1;

let count=0;
last_second=WAT;

while read line; do
	if [[ $line != *$last_second* ]] || [[ -e $last_second ]] ; then
		last_second=`echo $line | awk '{print $1}'`;
		echo "count = $count";
		let count=0;
	fi
	if [[ $line == *$last_second* ]] && [[ $line == *$WORDS* ]] ; then
		let count=count+1;
	fi
done
