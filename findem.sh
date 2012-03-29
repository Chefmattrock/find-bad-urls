#!/bin/bash

output="bad.log"
echo "starting tests for $1..." >> $output
counter=0
for url in `cat $1`
do
	code=`curl -s -w "%{http_code}" $url -o /dev/null`
	(test $code == 400 || test $code == 404) && (echo $url >> $output && $counter += 1) 
done
echo "found $counter bad urls" | tee -a $output

