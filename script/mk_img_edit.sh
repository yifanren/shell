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

if [ $# != 3 ]; then
    echo -e "  Usage: $0 parameter number is wrong."
    exit 1
fi

if [ ! -d $2 ]; then
    echo -e "  Usage: $2 not exist"
    exit 1
fi

secure_value=$1
secure_boot_path=$2
dest_path=$3
secure_key=`cat $2/128bit_efuse_key.txt`

build_cmd cp -rf $secure_boot_path/key_img_seed.bin $dest_path/key_img_seed.bin
build_cmd cp -rf $secure_boot_path/rsa_key.pem $dest_path/rsa_key.pem

if [ "$secure_value" == "1" ];then
    build_cmd eval sed -i 's:^EXTERNAL_MC_IMG_SECURE_BOOT_DISABLE.*:EXTERNAL_MC_IMG_SECURE_BOOT_DISABLE\ =\ NO:g' $dest_path/External.mk
elif [ "$secure_value" == "0" ];then
    build_cmd eval sed -i 's:^EXTERNAL_MC_IMG_SECURE_BOOT_DISABLE.*:EXTERNAL_MC_IMG_SECURE_BOOT_DISABLE\ =\ YES:g' $dest_path/External.mk
fi

build_cmd eval sed -i 's:^EXTERNAL_MC_IMG_128BIT_EFUSE_KEY.*:EXTERNAL_MC_IMG_128BIT_EFUSE_KEY\ =\ '"$secure_key"':g' $dest_path/External.mk
build_cmd eval sed -i 's:^EXTERNAL_MC_IMG_RSA_KEY_FILE.*:EXTERNAL_MC_IMG_RSA_KEY_FILE\ =\ '"$dest_path\/rsa_key.pem"':g' $dest_path/External.mk
