#!/bin/bash

PUBLIC_IP=`wget http://ipecho.net/plain -O - -q ; echo`
WLO1=`hostname -I | awk '{print $1}'`
SSID=`iwgetid -r`

echo "$PUBLIC_IP - $WLO1 - $SSID"

