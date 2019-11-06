#!/bin/bash

function cp_cmd()
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
    echo -e "  Usage: $0 path_of_src_dirctory path_of_project_root"
    exit 1
fi

src_path=$1
project_root_path=$2

if [ -f "$src_path/000list.txt" ]; then
    while read line || [[ -n ${line} ]];
    do
        file=$(echo $line | awk '{print $1}')
        path=$(echo $line | awk '{print $2}')
        dest_path=$project_root_path/$path
        cp_cmd cp -rf $src_path/$file $dest_path
    done < $src_path/000list.txt
else
    echo "Not exist $src_path/000list.txt"
    exit 1
fi
