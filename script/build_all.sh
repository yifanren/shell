#!/bin/bash

current=`pwd`
scriptDir=$current/../..
install_img_path=$scriptDir/XyunsOutput
img_path=$scriptDir/image_creator

function build_cmd()
{
    $@
    ERR=$?
    printf "$*"
    if [ "$ERR" != "0" ]; then
        echo -e "\033[47;31m $@ [ERROR] $ERR \033[0m" >> error.txt
    else
        echo "[ok]"
    fi
}

if [ ! -f 000list.txt ]; then
    echo -e "  Error: not exist this file"
    exit 1
fi

while read line || [[ -n ${line} ]];
do
    name=$(echo $line)
    build_cmd bash ./build_one.sh $name
done < 000list.txt

cd $scriptDir
DATE=`date +%Y%m%d-%H-%M-%S`
tar -Jcf XyunsOutput_$DATE.tar.xz XyunsOutput
