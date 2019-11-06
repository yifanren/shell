#!/bin/bash

function build_cmd()
{
    $@
    ERR=$?
    printf "$*"
    if [ "$ERR" != "0" ]; then
        echo -e "\033[47;31m [ERROR] $ERR \033[0m"
        exit 1
    else
        echo "[OK]"
    fi
}

if [ $# != 3 ]; then
    echo -e "  Usage: $0 path_of_bootloader_path value_of_secure path_of_dest"
    exit 1
fi

bootloader_path=$1
secure_value=$2
dest_path=$3

if [ -d "$bootloader_path" ]; then
    build_cmd cp $bootloader_path/bootloader.tar $dest_path
else
    echo "Not exist this $bootloader_path path"
    exit 1
fi
