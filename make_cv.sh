#!/bin/sh

DIR=$(pwd)

: ${INPUT:="cv.yml"}
: ${STYLE:="style.txt"}
: ${OUTPUT:="cv.pdf"}

INPUT="$DIR/$INPUT"
STYLE="$DIR/$STYLE"
OUTPUT="$DIR/$OUTPUT"

MAKE_CV_RB="/opt/yaml_cv/make_cv.rb"

cd $(dirname $MAKE_CV_RB)
while true; do
	ruby $MAKE_CV_RB -i $INPUT -s $STYLE -o $OUTPUT || sleep 1
	echo "Waiting for files to change ..."
	inotifywait -q $INPUT $STYLE
done
