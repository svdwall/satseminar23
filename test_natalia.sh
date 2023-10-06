#!/bin/bash


testfile=$1

res=$( natalia $testfile )
if [[ $? != 0 ]]
then
    exit -1
fi

if echo $res | grep -w "SATISFIABLE" &> /dev/null ;
then
    exit 0
else
    exit 1
fi
