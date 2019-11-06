#!/bin/bash

scriptDir=`pwd`

if [ $# != 5 ]; then
    echo -e " Usage: $0 wirelsee_or_wired secure_or_not_secure path_of_src path_of_dest"
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

wired_value=$1
secure_value=$2
src_path=$3
dest_path=$4
remote_file=$5

# wireless and noe_secure
if [ "$wired_value" == "0" ] && [ "$secure_value" == "0" ]; then
    echo "not exist this kernel"
fi

# wired and not_secure
if [ "$wired_value" == "1" ] && [ "$secure_value" == "0" ]; then
    src_kernel_path=$src_path/loongtle_std_not_secure
fi

# wireless and secure
if [ "$wired_value" == "0" ] && [ "$secure_value" == "1" ]; then
    src_kernel_path=$src_path/loongo_std_samsungA7
fi

# wired and secure
if [ "$wired_value" == "1" ] && [ "$secure_value" == "1" ]; then
    src_kernel_path=$src_path/loongtle_std_samsungA7
fi

if [ -f $remote_file ]; then
    remote_value=$(cat $remote_file)
    src_kernel_path=$src_path/*_$remote_value
fi

cp_cmd cp $src_kernel_path/* $dest_path/

cd $dest_path
rm -rf System.map
if [ -f "System.map.lzma" ]; then
    cp_cmd unlzma System.map.lzma
else
    echo "not exist System.map.lzma"
    exit 1
fi

cd $scriptDir
