Universe        = vanilla
Notification    = never
Executable	= one.sh

Output          = condor/run.out
Error           = condor/run.err
Log             = condor/run.log

Arguments	= $(Process)

request_gpus	= 1
request_memory	= 3GB

requirements	= regexp("rad", Machine) != True

Priority = 0

#queue 414
queue 4746
