#!/usr/bin/env bash
 
n=$[$1+0]

for j in {0..6}; do
    . one.sh $[$n*21+$j*3] &
    . one.sh $[$n*21+$j*3+1] &
    . one.sh $[$n*21+$j*3+2] &
    wait
done
 
