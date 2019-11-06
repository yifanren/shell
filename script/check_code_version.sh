#!/bin/bash

if [ $# != 2 ];then
    echo -e "  Usage: $0 CUSTOMER_NAME path_of_GIT_VERSION"
    exit 1
fi

git checkout master
git pull

CURSTOMER_NAME=$1
GIT_VERSION_PATH=$2

CODE_VERSION=`git log --pretty=format:"%cd | %h" --date=iso8601 -1`
echo ${CURSTOMER_NAME}_${CODE_VERSION} >> ${GIT_VERSION_PATH}
