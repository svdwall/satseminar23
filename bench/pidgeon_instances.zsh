#!/usr/bin/env zsh

echo "$1"
for i in {5..${1}..5};
do
    fits=$((($i * 3) / 4))
    nofits=$((($i * 4) / 3))
    echo "php ${fits} / ${nofits} => ${i}"
    cnfgen php $fits $i > php_${fits}_${i}.dimacs
    cnfgen php $nofits $i > php_${nofits}_${i}.dimacs;
done
