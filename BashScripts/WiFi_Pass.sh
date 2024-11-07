for profile in $(nmcli -t -f name connection show); do
    echo "Profile: $profile" >> WiFiPasswords.txt
    sudo nmcli connection show "$profile" | grep -i "psk=" >> WiFiPasswords.txt
    echo "" >> WiFiPasswords.txt
done
