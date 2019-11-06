#!/bin/bash

current=`pwd`
scriptDir=$current/../..
customer_path=$scriptDir/customer/archive
function_path=$scriptDir/customer/script
img_path=$scriptDir/image_creator
package_path=$scriptDir/image_creator/components/packages/package6
output_path=$scriptDir/XyunsOutput

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

customer_name=$1
cd $customer_path

#build one
if [ $# != 1 ] || [ ! -d "$customer_name" ]; then
    echo -e " Usage: customer_name" && ls
    exit 1
fi

if [ ! -d $output_path ]; then
    mkdir $output_path
fi

#clean
cd $img_path
build_cmd bash ./clean.sh

#get need info
cd $function_path
secure_value=$(cat $customer_path/$customer_name/def/secure.txt)
customer_name=$(cat $customer_path/$customer_name/def/name.txt)
wired_value=$(cat $customer_path/$customer_name/def/lan.txt)
name_version=$(bash ./get_ver.sh $customer_path/$customer_name/def/ver.txt $scriptDir/external/version_number)
version=$(echo $name_version | awk '{print $2}')
product_version=`cat $scriptDir/external/version_number/product/ver.txt`
model=`cat $scriptDir/external/ota/$customer_name/model.txt`
custom=`cat $scriptDir/external/ota/$customer_name/custom.txt`

#check code version
build_cmd bash ./check_code_version.sh $customer_name $output_path/code_version.txt

#copy mk
build_cmd bash ./copy_general.sh $customer_path/$customer_name/mk $scriptDir

#finish mk_img and mk_ap
build_cmd bash ./mk_img_edit.sh $secure_value $scriptDir/external/secure_boot/$customer_name $img_path
build_cmd bash ./mk_ap_edit.sh $secure_value $scriptDir/system/include/External.mk
echo "EXTERNAL_MC_IMG_VERSION = $version" >> $img_path/External.mk
#build AP
build_cmd bash ./build_copy_ap.sh $scriptDir/system/branch_src_sharedMemory_integration $package_path/AP

#copy bootloder
build_cmd bash ./copy_bootloader.sh $scriptDir/external/bootloader/$customer_name $secure_value $package_path

#copy kernel
build_cmd bash ./copy_kernel.sh $wired_value $secure_value $scriptDir/external/kernel $package_path $customer_path/$customer_name/def/remote.txt

#copy boot_animation
build_cmd bash ./copy_boot_animation.sh $customer_name $scriptDir/external/boot_animation $package_path

#copy resource
build_cmd bash ./copy_general.sh $customer_path/$customer_name/conf $scriptDir
build_cmd bash ./copy_general.sh $customer_path/$customer_name/res $scriptDir
build_cmd bash ./copy_general.sh $customer_path/$customer_name/rss $scriptDir

#get version
echo "DEVICE_VERSION= $name_version" >> $package_path/AP/bin/airfly.conf
#get oat info
build_cmd bash ./get_ota.sh $scriptDir/external/ota/$customer_name $package_path/AP/bin/airfly.conf
echo "PRODUCT_VERSION=$product_version" >> $package_path/AP/bin/airfly.conf

#build img
DATE=`date +%Y%m%d-%H-%M-%S`
NORMAL_IMAGE_FILE=install.img_${version}_${customer_name}_${DATE}
build_cmd bash ./build_img.sh 0 ${img_path} ${NORMAL_IMAGE_FILE}
echo "${customer_name}/${NORMAL_IMAGE_FILE}  custom=$custom version=$version model=$model product_version=$product_version" >> $output_path/img_info.txt

if [ "${secure_value}" == "1" ]; then
    EFUSE_IMAGE_FILE=install.img_${version}_${customer_name}_${DATE}_efuse
    build_cmd bash ./build_img.sh 1 ${img_path} ${EFUSE_IMAGE_FILE}
    echo "${customer_name}/${EFUSE_IMAGE_FILE}  custom=$custom version=$version model=$model product_version=$product_version" >> $output_path/img_info.txt
fi

EFUSE_IMAGE_FILE=install.img_${version}_${customer_name}_${DATE}_upgrade
build_cmd bash ./build_img.sh 2 ${img_path} ${EFUSE_IMAGE_FILE}
echo "${customer_name}/${EFUSE_IMAGE_FILE}  custom=$custom version=$version model=$model product_version=$product_version" >> $output_path/img_info.txt

#make install directory
cd $output_path
if [ ! -d $customer_name ]; then
build_cmd mkdir $customer_name
fi
build_cmd cp $img_path/install.img* $output_path/$customer_name
cd $current
