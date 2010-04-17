#close interface
ifconfig wlan0 down
#Release dhcp
dhclient -r wlan0
#Turn the interface on with the following command:
ifconfig wlan0 up
#Scan for a list of all the available access points:
#iwlist wlan0 scanning
#Select the access point with the following command:
iwconfig wlan0 essid "kpanic"
#Set WEP or WPA passphrase, if needed:
#iwconfig wlan0 key PASSPHRASE
# usar s: al comienzo de la clave si es en ASCII ?¿
#Finally, connect to DHCP server and obtain an IP address:
dhclient wlan0
