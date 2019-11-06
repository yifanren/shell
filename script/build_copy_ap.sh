#!/bin/bash

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
if [ $# != 2 ]; then
    echo -e "  Usage: $0 parameter number wrong."
    exit 1
fi

branch_path=$1
dest_path=$2

build_cmd cd $branch_path && build_cmd make clean && build_cmd make
build_cmd cd $branch_path/Unit_test/Casablanca && build_cmd make release

if [ ! -d $dest_path ];then
    build_cmd mkdir $dest_path
fi

build_cmd rm -rf $dest_path/bin
build_cmd cp -rf $branch_path/Unit_test/Casablanca/bin $dest_path/bin
