#!/bin/bash

current=`pwd`
scriptDir=$current/../..

if [ $# != 1 ]; then
    echo -e "  Usage: AIRFLY_CUSTOMER_NAME: xyuns/blueperrypi"
    exit 1
fi

airfly_customer_name=$1
newString="AIRFLY_CUSTOM:=${airfly_customer_name}"
airfly_path=$scriptDir/system/branch_src_sharedMemory_integration/Unit_test/Casablanca/AirFly

sed -i "5 d" $airfly_path/Config.in
sed -i "5 i$newString" $airfly_path/Config.in
cat $airfly_path/Config.in
