ifconfig wlan0 10.10.0.1 netmask 255.255.255.0
start isc-dhcp-server
echo 1 > /proc/sys/net/ipv4/ip_forward
iptables -t nat -A POSTROUTING -s 10.10.0.0/16 -o ppp0 -j MASQUERADE
hostapd /etc/hostapd/hostapd.conf 
