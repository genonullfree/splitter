#!/bin/bash
#
# author: geno nullfree
#
#for best results, if doing a folder full of mp3's, run like so:
#list=( *mp3 ); for i in "${list[@]}"; do sh splitter.sh "$i"; done
#

if [ $1 ]; then
    file_name=$1
else
    echo "You must provide the mp3 to be split as the argument"
fi

# the second argument is the time duration of the mp3 segments
# it can be given in seconds or hh:mm:ss format
if [ $2 ]; then
    duration=$2
else
    duration=1800
fi

rm -rf "$file_name-split"
mkdir "$file_name-split"
count=0;

while( [[ $(ffmpeg -i "$file_name" -acodec copy -t $duration -ss $(($duration*count)) "$file_name-split"/"$count-$file_name" &> /dev/null)==0 ]] ); do
echo "ffmpeg -i "$file_name" -acodec copy -t $duration -ss $(($duration*count)) "$file_name-split"/"$count-$file_name""
    if [[ $(wc -c "$file_name-split"/"$count-$file_name"|cut -f 1 -d ' ') -le 550 ]]; then
        rm "$file_name-split"/"$count-$file_name"
        exit
    fi  
    count=$((count+1))
done
