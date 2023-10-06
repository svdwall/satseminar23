#!/bin/bash


testfile=$1

res=$( thies $testfile )
if [[ $? != 0 ]]
then
    exit -1
fi

if echo $res | grep -w "v" &> /dev/null ;
then
    exit 0
else
    exit 1
fi
