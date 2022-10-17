#!/bin/bash
apt list --upgradable | cut -d / -f 1 | cut -d / -f 1 > buckets.txt
FILE=buckets.txt
# read $FILE using the file descriptors
exec 3<&0
exec 0<$FILE
while read line
do
	# use $line variable to process line
    echo "Nome do Bucket: $line"
    mc replicate resync status srv1/$line
done
exec 0<&3