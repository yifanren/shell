#!/bin/bash

if [ $# != 2 ]; then
    echo -e "  Usage: value_of_secure path_of_mk"
    exit 1
fi

function sed_cmd()
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

if [ ! -f "$2" ]; then
    echo "mk not exist"
    exit 1
fi

secure_value=$1
mk_file_path=$2

#0 not secure SECURE_BOOT_DISABLE yes
if [ "$secure_value" == 0 ]; then
    sed_cmd eval sed -i 's:^EXTERNAL_MC_SECURE_BOOT_DISABLE.*:EXTERNAL_MC_SECURE_BOOT_DISABLE\ =\ YES:g' $mk_file_path
fi

if [ "$secure_value" == 1 ]; then
    sed_cmd eval sed -i 's:^EXTERNAL_MC_SECURE_BOOT_DISABLE.*:EXTERNAL_MC_SECURE_BOOT_DISABLE\ =\ NO:g' $mk_file_path
fi
