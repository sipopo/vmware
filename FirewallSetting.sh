#/!bin/bash

echo -n "Enter password on vcenter:"
read -e password

export VI_USERNAME=osipov
export VI_PASSWORD=$password
export VI_SERVER=vcent.corbina.net



#env | grep -i vi_

for server in `cat $1` 
do

   echo $server

   #echo vm2.kursk.corbina.net
   #esxcli -h $server network firewall ruleset set -a false -r webAccess

   esxcli -h $server network firewall ruleset set -a true -r ntpCLient
#   esxcli -h $server network firewall ruleset allowedip add -i "85.21.78.0/24" -r ntpClient
#   esxcli -h $server network firewall ruleset allowedip remove -i "127.0.0.1" -r ntpClient

   #for service in webAccess vSphereClient snmp CIMHttpServer CIMHttpsServer  
#   for service in webAccess snmp CIMHttpServer CIMHttpsServer
#   do
#	echo $service	
#	esxcli -h $server network firewall ruleset set -a false -r $service
#   	for ip in 89.179.138.0/24 85.21.106.0/24 83.102.180.0/24
#   	do
#		#echo $ip
#		esxcli -h $server network firewall ruleset allowedip add -i "$ip" -r $service
#   	done
#   done 

   esxcli -h $server network firewall ruleset allowedip list
done

