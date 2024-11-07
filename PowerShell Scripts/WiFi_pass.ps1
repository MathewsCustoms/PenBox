(netsh wlan show profiles | Select-String "All User Profile").ForEach({
    $profile = $_.ToString().Split(':')[1].Trim()
    $passwordInfo = netsh wlan show profile name="$profile" key=clear | Select-String "Key Content"
    if ($passwordInfo) {
        "Profile: $profile" | Out-File -Append WiFiPasswords.txt
        $passwordInfo.ToString().Trim() | Out-File -Append WiFiPasswords.txt
        "`n" | Out-File -Append WiFiPasswords.txt
    }
})
