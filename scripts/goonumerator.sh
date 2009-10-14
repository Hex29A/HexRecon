# Goonumerator 0.1a by Hex29A http://hex29a.wordpress.com ,2009
# quick'n'dirty script to harvest e-mailaddresses of Google Search.
# run at your own risk.

#!/bin/sh
APPNAME="goonumerator"
LOGFILE="/tmp/$APPNAME.tmp"
# Instructions 
if [ "$1" = "" ] ; then
	echo -e "\nUsage: $APPNAME domain.tld [number of pages to search]"
	exit

fi

#Checking whether doing a quick 10 result search or not
if [ "$2" = "" ] ; then
	let ARG2=1
else
	let ARG2=$2
fi

echo "" > $LOGFILE 
COUNTER=0
let MAX=ARG2*10
#Loop through the search results, grepping email addresses and save them in /var
while [ $COUNTER -lt $MAX ]; do
w3m -no-cookie -dump "http://www.google.com/search?q=site:$1+%40$1&start=$COUNTER"   | sed -e 's/\ /\n/g' | grep .@. >> $LOGFILE
let COUNTER=COUNTER+10
done

#filter and sort the addresses and trim dots at the end
cat $LOGFILE | sort | uniq | sed -e 's/\.$//g'
