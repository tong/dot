#!/bin/sh
url=https://sdfsdfs.net/
status=$(curl -sL -w "%{http_code}" "$url" -o /dev/null --connect-timeout 3 --max-time 5)
if [ $status != "200" ]; 
then
   echo " $url IS DOWN" ;
fi
