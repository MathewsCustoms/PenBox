#!/bin/bash
#Auto Connect To Bluetooth  
sudo systemctl start Bluetooth

bluetoothctl << EOF
power on
agent on
default-agent
discoverable on
pairable on
trust <Enter Phone Your MAC Address Here>
connect <Enter Phone Your MAC Address Here>
EOF