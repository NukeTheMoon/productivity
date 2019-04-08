#!/bin/bash

FILE=$1
SIDES=( 214 460 463 167 )
FILENAMES=( "thumb_d" "thumb_m" "thumb_d_jumbo" "thumb_d_mini" )

dpkg -s graphicsmagick > /dev/null

if [ $? != 0 ]; then
    echo -e "\e[93mGraphicsMagick is not installed, exiting"
    exit 1
fi

if [ ! -f $FILE ]; then
    echo -e "\e[93mFile not found"
    exit 1
fi

ext=`file -b $FILE | awk '{print $1}'`

if [ $ext != "JPEG" ] && [ $ext != "PNG" ]; then
    echo -e "\e[93mDoesn't look like a JPEG or PNG file, exiting"
    exit 1
fi

w=`identify -format %w $FILE`
h=`identify -format %h $FILE`

for (( i=0; i<${#SIDES[@]}; i++ ));
do
    targetSide=${SIDES[$i]}
    shorterSide=$(( $w < $h ? $w : $h ))
    crop="-gravity center -crop "$shorterSide"x"$shorterSide"+0+0"
    resize="-resize "$targetSide"x"$targetSide"!"
    fileName="${FILENAMES[$i]}"
    fileDir="$(dirname "${FILE}")/"
    fileExt="."${FILE##*.}""
    convert $FILE $crop $resize $fileDir$fileName$fileExt
done

