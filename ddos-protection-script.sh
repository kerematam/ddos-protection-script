#!/bin/bash

# Number of connections to block associated IP address
# You should set this value according to your client's traffic habits.
# I use 200 for a simple forum web site.
NoCon=200

# script log destionation
# LogDes="/var/wwww/html"
LogDes="."

# get number of lines from commmand
ln=$(netstat -anp |grep 'tcp\|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | wc -l)
i="0"

while [ $i -lt $ln ]
do
	ip=$(netstat -anp |grep 'tcp\|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | awk '{print $2}'| sed -n $i'p')
	NoReq=$(netstat -anp |grep 'tcp\|udp' | awk '{print $5}' | cut -d: -f1 | sort | uniq -c | sort -nr | awk '{print $1}'| sed -n $i'p')

	if [ $NoReq -ge $NoCon ]
		then
 		route add $ip reject #>>/var/www/html/check-ddos-logs/ban_ip.txt

 		echo $ip>>$LogDes/blocked-ip-list.txt
 		date>>$LogDes/blocked-ip-list.txt
 		echo $NoReq>>$LogDes/blocked-ip-list.txt
 		
 		# Uncomment line below to log blocked IP's country
		# geoiplookup $ip>>$LogDes/blocked-ip-list.txt
		
		echo $ip;
		echo $NoReq;
		
		# Uncomment line below to see blocked IP's country
		# geoiplookup $ip;
	fi
	i=$[$i+1]
	echo $i
done
