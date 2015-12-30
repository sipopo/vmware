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
   esxcli -h $server system settings advanced list | grep -A 10 BlueScreenTimeout
   esxcli -h $server system settings advanced set -o "/Misc/BlueScreenTimeout" -i 300
   esxcli -h $server system settings advanced list | grep -A 10 BlueScreenTimeout

done

