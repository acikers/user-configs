#!/bin/bash

if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]]; then
	echo $0 [no_of_files] [min_size] [max_size];
	exit 1;
fi

let no_of_files=$1;
let min_size=$2;
let max_size=$3;
let counter=1;

while [[ $counter -le $no_of_files ]];
do
	echo Creating file \#$counter;
	dd bs=1 count=$(($RANDOM % ($max_size - $min_size) + $min_size)) if=/dev/urandom of=./random_file.$counter;
	let counter+=1;
done
