#!/bin/bash
CURRENT_PATH=`pwd`

function build_cmd()
{
    $@
    ERR=$?
    printf "$*"
    if [ "$ERR" != "0" ];then
        echo -e "\033[47;31m [ERROR] $ERR \033[0m"
        exit 1
    else
        echo "[OK]"
    fi
}

image_vesion=$1
img_path=$2
outputfile=$3

if [ $# != 3 ]; then
    echo -e "  Usage: $0 parameter number wrong."
    exit 1
fi

cd $img_path

if [ ! -d "components/packages/package6/AP/etc" ];then
    echo "no etc."
    build_cmd mkdir components/packages/package6/AP/etc
fi

if [ $image_vesion == "1" ];then
    build_cmd make image install_ap=1 hash_imgfile=1 efuse_write=1 install_boot=1 PACKAGES=package6
elif [ $image_vesion == "0" ];then
    build_cmd make image install_ap=1 hash_imgfile=1 install_boot=1 PACKAGES=package6
elif [ $image_vesion == "2" ]; then
    build_cmd make image install_ap=1 hash_imgfile=1 PACKAGES=package6
fi
build_cmd mv install.img $outputfile
cd $CURRENT_PATH
