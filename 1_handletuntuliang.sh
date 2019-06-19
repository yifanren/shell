#!/bin/bash

if [ $# != 1 ]; then
    echo -e " Usage: ./1_handletuntuliang.sh handle_file_name"
    exit 1
fi
echo "START HANDLE"

CURRENT_PATH=`pwd`
HANDLE_FILE_NAME=$1
RESOULT_FILE_NAME=re_${HANDLE_FILE_NAME}

while read line || [[ -n ${line} ]];
do
    sed 's/- /-/g' ${HANDLE_FILE_NAME} > ${RESOULT_FILE_NAME}
done < ${CURRENT_PATH}/${HANDLE_FILE_NAME}

cat ${RESOULT_FILE_NAME} | awk '{print $7}' >> ${RESOULT_FILE_NAME}

echo "END HANDLE"
