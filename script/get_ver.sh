#!/bin/bash


if [ $# != 2 ]; then
    echo -e "  Usage: $0 path_of_ver.txt path_of_version_number"
    exit 1
fi


ver_prefix=`grep "prefix=" $1 | cut -d '=' -f 2 | xargs echo -n`
ver_number=`grep "number=" $1 | cut -d '=' -f 2 | xargs echo -n`

if [ -z "$ver_prefix" ]; then
    echo -e "  Error: Fail to get version prefix"
    exit 2
fi

if [ -z "$ver_number" ]; then
    echo -e "  Error: Fail to get version number"
    exit 2
fi


if [[ "$ver_prefix" =~ ".txt" ]]; then
    file_ver_prefix=$2/prefix/$ver_prefix
    result_prefix=`cat $file_ver_prefix`
else
    result_prefix=$ver_prefix
fi


if [[ "$ver_number" =~ ".txt" ]]; then
    ver_number_pure=`echo -n "$ver_number" | cut -d '.' -f 1`
    dir_ver_number=$2/number/$ver_number_pure
    number_A=`cat $dir_ver_number/A.txt`
    number_B=`cat $dir_ver_number/B.txt`
    number_C=`cat $dir_ver_number/C.txt`
    result_number=$number_A.$number_B.$number_C
else
    result_number=$ver_number
fi


result=$result_prefix" "$result_number

echo -n "$result"
