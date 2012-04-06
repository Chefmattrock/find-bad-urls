#!/bin/bash

log() {
	echo "$@" | tee -a $output
}

if ! [ $1 ]; then
	echo "usage: findem.sh <url_file> [output_file]"
	exit
fi

if [ "$#" -eq 2 ]; then
	output=$2
else
	output="bad.log"
fi

log "starting tests for $1 at `date -u +%s`000"
counter=0
for url in `cat $1`
do
	code=`curl -sL -w "%{http_code}" $url -o /dev/null`
	(test $code == 400 || test $code == 404) && (echo $url >> $output && $counter += 1) 
done
log "found $counter bad urls"

