#!/bin/bash 
JPEGTRAN=$(which jpegtran)
GM=$(which gm)
PARALLEL=$(which parallel)
SIZE=$1 #1st command line argument: the % resize value e.g 40% for 40% reduction in pixel resolution
QUALITY=$2 #2nd command line arguement: the conversion quality e.g 80 for 80% of original JPG quality
DEBUG=$3 #print sizes
#install pre-requisites if not installed
if !(echo "$JPEGTRAN" | grep -sw "/usr/bin/jpegtran" > /dev/null); then
	sudo apt-get install libjpeg-progs
fi
if !(echo "$GM" | grep -sw "/usr/bin/gm" > /dev/null); then
	sudo apt-get install graphicsmagick
fi
if !(echo "$PARALLEL" | grep -sw "/usr/bin/parallel" > /dev/null); then
	sudo apt-get install parallel
fi
# resize value and quality arguments must be supplied
#if ([ -z "$1" ] || [[ $1 = ^[0-9]{2} ]]); then
if ([ -z "$1" ] ||[ -z "$1" ]) ; then
	echo "USAGE: You must supply two arguments:"
	echo "./optimize.sh resize quality info"
	echo "where:  resize is a value e.g 40 for 40% smaller and quality is a value like 80 for 80% of the original quality and info [0/1] is whether to print sizes"
	echo "Successive runs result to unwanted results: poor quality"
	exit 1
fi

if !([[ $1 =~ ^[0-9]{2}$ ]]); then
	echo "Argument 1 needs to be a 2 digit number, best is 40"
	exit 1
fi

if !([[ $2 =~ ^[0-9]{2}$ ]]); then
	echo "Argument 2 needs to be a 2 digit number, best is 80"
	exit 1
fi


echo "This program overwrites your images, are you sure you want to continue?"
echo "Reply with y to continue, else just hit enter"
read reply

if [[ $reply == "y" ]]; then
	#echo "passed:"
	if([[ $DEBUG -eq 1 ]]); then
		echo ""
		echo "Before conversion:"
		ls -s -h --hide=*.sh
	fi
	#find . -mindepth 1 -maxdepth 1 ! -name *.sh -exec jpegtran -copy none -progressive -outfile "{}" "{}" \;
	#find . -mindepth 1 -maxdepth 1 ! -name *.sh -exec gm convert "{}" -resize $SIZE% -quality $QUALITY -interlace Line "{}" \;
	find . -mindepth 1 -maxdepth 1 ! -name *.sh | parallel -j 4 jpegtran -copy none -progressive -outfile "{}" "{}" \;
	find . -mindepth 1 -maxdepth 1 ! -name *.sh | parallel -j 4 gm convert "{}" -resize $SIZE% -quality $QUALITY -interlace Line "{}" \;
	echo "Done."
	if([[ $DEBUG -eq 1 ]]); then
		echo ""
		echo "After conversion:"
		ls -s -h --hide=*.sh
	fi
else
	echo "terminated..."
fi


