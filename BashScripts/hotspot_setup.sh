#!/bin/bash

# Set a static IP for wlan0 (the internal WiFi interface)
ip link set dev wlan0 down
ip addr add 192.168.4.1/24 dev wlan0
ip link set dev wlan0 up

# Configure dnsmasq for DHCP
cat <<EOF > /etc/dnsmasq.conf
interface=wlan0
dhcp-range=192.168.4.10,192.168.4.50,255.255.255.0,24h
EOF

# Start dnsmasq
systemctl start dnsmasq

# Configure hostapd for the hotspot
cat <<EOF > /etc/hostapd/hostapd.conf
interface=wlan0
driver=nl80211
ssid=MyPiHotspot
hw_mode=g
channel=6
wmm_enabled=0
macaddr_acl=0
auth_algs=1
ignore_broadcast_ssid=0
wpa=2
wpa_passphrase=YourStrongPassword
wpa_key_mgmt=WPA-PSK
rsn_pairwise=CCMP
EOF

# Set hostapd to use this configuration file
sed -i 's|#DAEMON_CONF=""|DAEMON_CONF="/etc/hostapd/hostapd.conf"|' /etc/default/hostapd

# Start hostapd
systemctl start hostapd

# Enable IP forwarding
sysctl -w net.ipv4.ip_forward=1

# Configure NAT with iptables
iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
iptables -A FORWARD -i eth0 -o wlan0 -m state --state RELATED,ESTABLISHED -j ACCEPT
iptables -A FORWARD -i wlan0 -o eth0 -j ACCEPT
