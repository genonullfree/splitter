#!/bin/bash
#
# author: geno nullfree
#
#for best results, if doing a folder full of mp3's, run like so:
#list=( *mp3 ); for i in "${list[@]}"; do sh splitter.sh "$i"; done
#

rm -rf "$1-split"
mkdir "$1-split"
count=0;

while( [[ $(ffmpeg -i "$1" -acodec copy -t 1800 -ss $((1800*count)) "$1-split"/"$count-$1")==0 ]] ); do
echo "ffmpeg -i "$1" -acodec copy -t 1800 -ss $((1800*count)) "$1-split"/"$count-$1""
    if [[ $(wc -c "$1-split"/"$count-$1"|cut -f 1 -d ' ') -le 550 ]]; then
        rm "$1-split"/"$count-$1"
        exit
    fi  
    count=$((count+1))
done
