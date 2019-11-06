#!/bin/bash
currentDir=`pwd`

#change special customer version
while read line
do
    echo "*************$line ***********************"
    cat $currentDir/../archive/$line/def/ver.txt
    if [ $line == "xh_x7_chuangmilk" ]; then
        sed -i 's:^prefix.*:prefix="8.3.6":g' $currentDir/../archive/$line/def/ver.txt
    fi

    if [ $line == "xh_x5_normal_boxfish" ]; then
        sed -i 's:^number.*:number="8.3.6":g' $currentDir/../archive/$line/def/ver.txt
    fi

    if [ $line == "xh_car_5g_550_KX3" ]; then
        sed -i 's:^number.*:number="6.0.6":g' $currentDir/../archive/$line/def/ver.txt
    fi

    if [ $line == "xh_car_2.4g_ARES" ] || [ $line == "xh_car_550P_ares" ] || \
       [ $line == "xh_car_550P_ares_ccp" ] || [ $line == "xh_car_5g_ares" ] || \
       [ $line == "xh_consumer_5g_ARES" ]; then
        sed -i 's:^number.*:number="19.0701":g' $currentDir/../archive/$line/def/ver.txt
    fi
    cat $currentDir/../archive/$line/def/ver.txt
    echo
done < special_version_customer.txt

#change normal customer version
cat $currentDir/../../external/version_number/number/car/C.txt
sed -i 's:.*:7:g' $currentDir/../../external/version_number/number/car/C.txt
cat $currentDir/../../external/version_number/number/car/C.txt
echo
cat $currentDir/../../external/version_number/number/normal/C.txt
sed -i 's:.*:7:g' $currentDir/../../external/version_number/number/normal/C.txt
cat $currentDir/../../external/version_number/number/normal/C.txt
echo
#change ota
cat $currentDir/../../external/version_number/product/ver.txt
sed -i 's:.*:0.08.000227U:g' $currentDir/../../external/version_number/product/ver.txt
cat $currentDir/../../external/version_number/product/ver.txt
