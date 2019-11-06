#!/bin/bash

if [ $# != 2 ]; then
    echo -e "  Usage: $0 path_of_ota path_of_package_airfly"
    exit 1
fi

if [ ! -d "$1" ]; then
    echo -e "  Not exist this directory"
    exit 1
fi

function build_cmd()
{
    $@
    ERR=$?
    if [ "$ERR" != "0" ];then
        exit 1
    fi
}

custom=`cat $1/custom.txt`
model=`cat $1/model.txt`
token=`cat $1/token.txt`
airfly_path=$2

build_cmd echo "OTA_CUSTOM=$custom" >> $airfly_path
build_cmd echo "OTA_MODEL=$model" >> $airfly_path
build_cmd echo "OTA_TOKEN=$token" >> $airfly_path
