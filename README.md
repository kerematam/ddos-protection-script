# ddos-protection-script
Simple bash script for DDoS protection consist of number of connections per IP. Script simply check number of connection per IP. If it is over some threshold (you can set this value within script), associated IP will be blocked via route command. 

IMPORTANT!
Script blocks IPs permanently. You can either reboot the server to let all blocked IP or follow instructions below.

To unblock, script's blocked IPs.
1- Check log file, named "blocked-ip-list.txt" to see blocked IP list by script.
  #cat blocked-ip-list.txt
Or check all blocked IPs with netstat command
  #netstat -rn

2- To unblock IP use command :
  #route delete <blocked-ip>
where "<blocked-ip>" is the IP you wanna unblock

Check link below for further reading about route command.
http://www.cyberciti.biz/tips/how-do-i-drop-or-block-attackers-ip-with-null-routes.html

Check link below for further readin about nstat's DDoS detection methods.
http://safesrv.net/server-slow-check-whos-connecting-and-how-many-connections-they-have/

HOW TO USE 
To keep your server secure with this script continuesly, you should run it periodically for some period of time. 
Personally I run this script for every one minute on my server via crontab. Pretty useful for small forum sites.
