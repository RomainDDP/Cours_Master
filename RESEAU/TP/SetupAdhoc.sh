ifconfig wlp1s0 down
iwconfig wlp1s0 mode ad-hoc channel 4 essid "RT0" key 1234567890
ifconfig wlp1s0 192.168.68.1 netmask 255.255.255.0
ifconfig wlp1s0 up

#iwlist wlp1s0 scan
