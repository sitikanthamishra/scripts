#!/bin/bash

dt=`date +%F`

df -BM /> /tmp/du-$dt

while read line
do
    fields=`echo $line | awk '{print NF}'`
    case $fields in
    1) echo -n "$dt $line ";;
    5) echo -n "$dt "
        echo $line | awk '{print $4}';;
    6) echo -n "$dt "
        echo $line | awk '{print $1,$3,$4,$5}';;
    esac
done < /tmp/du-$dt > /tmp/sto-$dt
