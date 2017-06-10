#!/bin/sh

#初始化配置
interface=$( uci show netkeeper.nk.interface | cut -d "'" -f 2 )
password=$( uci show netkeeper.nk.password | cut -d "'" -f 2 )
if [ ${password} ]
then
    uci set "network.${interface}.password=${password}"
    uci commit
fi

#启动pppoe服务器。TODO：检测是否有pppoe服务器进程，再启动
#检测有效的PPPoE服务进程
if ((! (ps | grep "server -k -I br-lan" | grep -v "grep") ))
then 
	pppoe-server -k -I br-lan
fi

#删掉之前的log，加快读取速度
rm /tmp/pppoe-server.log

while :
do
#读取log最后一个账号
#    username=$(grep "network.wan.username" /tmp/pppoe-server.log  | tail -n 1)
#    username=$(grep "Peer" /tmp/pppoe-server.log  | tail -n 1 | cut -c 4-)
#    username=${username#*Peer }
#    username=${username%% fail*}
#    echo "original username is ${username}"
    username=$(grep "Peer" /tmp/pppoe-server.log  | tail -n 1 | cut -c 8-)
#    echo "username is ${username}"
#    username=${username#*^M}
    username=${username%% fail*}


    if [ "$username" != "$username_old" ]
    then
        ifdown netkeeper
        uci set "network.${interface}.username=""\r${username}"
        uci commit
        ifup netkeeper
        username_old="$username"
	logger "pppoe_interface="${interface}
        logger "pppoe_username="${username}
	logger "pppoe_password="${password}
    fi
#    echo "wait"
    sleep 10

done
