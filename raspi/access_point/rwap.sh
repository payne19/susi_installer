#!/bin/bash

if [ "$EUID" -ne 0 ]
	then echo "Must be root"
	exit
fi


cd /etc/hostapd/
cp hostapd.conf hostapd.conf.bak
sed -i '1,14d' hostapd.conf

rm -f /etc/network/interfaces.d/wlan-hostap
cp /etc/network/interfaces.d/wlan.client /etc/network/interfaces.d/wlan-client

# systemctl unit setup
# these are dual to wap.sh
systemctl disable hostapd
systemctl disable dnsmasq
systemctl disable ss-susi-ap-msg
# by default everything is local now, so we can keep susi linux running
#systemctl enable ss-susi-linux@pi.service
systemctl enable ss-susi-login.service

echo "Please reboot"
sleep 10;
reboot
