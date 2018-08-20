#!/bin/sh

dir=out/tmp.$1

egrep '(War|Err)' $dir/run-*/fit.*/log*

rm -r $dir/run-*
gzip $dir/{out,log}*
