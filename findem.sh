#!/bin/bash

output="bad.log"
for url in `cat urls.csv`
do
	code=`curl -s -w "%{http_code}" $url -o /dev/null`
	(test $code == 400 || test $code == 404) && (echo $url >> $output) 
done
