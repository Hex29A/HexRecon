#Copyright (c) 2009, Hex29A (http://hex29a.wordpress.com)
#
#Permission to use, copy, modify, and/or distribute this software for any
#purpose with or without fee is hereby granted, provided that the above
#copyright notice and this permission notice appear in all copies.
#
#THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES
#WITH REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF
#MERCHANTABILITY AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR
#ANY SPECIAL, DIRECT, INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES
#WHATSOEVER RESULTING FROM LOSS OF USE, DATA OR PROFITS, WHETHER IN AN
#ACTION OF CONTRACT, NEGLIGENCE OR OTHER TORTIOUS ACTION, ARISING OUT OF
#OR IN CONNECTION WITH THE USE OR PERFORMANCE OF THIS SOFTWARE.
#

#Version 0.1

#!/bin/sh
clear

if [ "$1" = "" ]; then
	echo -e "Usage: siteinfo.sh [site.tld] \n"
	exit

fi

HOST=$1
NETBLOCK=`curl --silent http://toolbar.netcraft.com/site_report?url=$HOST | grep Netblock | head -n 1 | sed -e 's/<[^>]*>//g' -e 's/Netblock\ owner//g'`
IP=`host $HOST|head -n 1|sed -e 's/has\ address/X/g' |awk '{print $3}'`
REVERSE=`dig -x $IP|grep IN|tail -n 1| awk '{print $5}'`



echo "Network info for: $1"
echo ""
echo -e "IP: \t\t$IP"
echo -e "REVERSE: \t$REVERSE"
echo -e "NETBLOCK: \t$NETBLOCK"
echo ""

