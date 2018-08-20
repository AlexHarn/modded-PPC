#!/bin/bash

ice=../ice
ppc=../gpu/ppc

. ../ocl/src
. ../llh/src

strings=`seq 1 86`
#strings=(19 24 57 62 63 80 81)

if test $# -gt 0; then echo -n $*: `date`; fi

m=0
k=$[$1+0]
a=$1
q=$2


if test "$FWID" = ""; then FWID=12; fi
if test "$SREP" = ""; then SREP=10; fi

set -o pipefail

n=4746

echo "waiting for condor jobs (run condor_submit condor.one)"
for b in $q""; do
    while true; do
	for i in ../fit.*; do
	    echo $i
	    ls -la $i >& /dev/null
	    if test -d $i && test -e $i/host && ! test -e $i/done; then
		t1=`ls --time-style="+%s" -ltr $i 2>> llh.log | tee llh.foo | awk 'END {print $6}'`
		endc=$?; if test $endc -gt 0; then cat llh.foo >> llh.log; fi
		t2=`date "+%s"`
		if test $endc -ge 0 && test $[$t2-$t1] -gt $[10*60]; then echo rm $i/host 2>> llh.log; fi
	    fi
	done

	for i in ../fit.$b-*; do ls -la $i >& /dev/null; done
	if test `ls ../fit.$b-*/done 2>/dev/null | wc -l`"" -eq "$n"; then break; fi
	sleep 10
    done

    for i in `seq 0 $[$n-1]`; do cat ../fit.$b-$i/log 1>&2; cat ../fit.$b-$i/{fla,out}; done 2>tmp/log.$a.$b |
    tee tmp/out.$a.$b | awk '/^[?*]/ { llh+=$2; } END {print llh}' | tee tmp/a.$a.$b | awk '{printf " "$0}'
done

echo "cleaning up"

echo
grep Error tmp/log.$a.*

d=`mktemp -d tmp/run-XXXXXX`
mv ../fit.* $d 2>/dev/null

while test -e stop; do echo -n "." 1>&2; sleep 100; done
