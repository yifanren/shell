#!/bin/bash

if [ $# != 3 ]; then
    echo -e "  Usage: $0 name path_of_src path_of_des"
    exit 1
fi

function cp_cmd() {
    $@
    ERR=$?
    printf "$* "
    if [ "$ERR" != "0" ]; then
        echo -e "\033[47;31m [ERROR] $ERR \033[0m"
        exit 1
    else
        echo "[ok]"
    fi
}

audio_path=$2/audio/$1
video_path=$2/video/$1
dest_path=$3

if [ -d "$audio_path" ]; then
    cp_cmd cp -rf $audio_path/* $dest_path
fi

if [ -d "$video_path" ]; then
    cp_cmd cp -rf $video_path/* $dest_path
fi
