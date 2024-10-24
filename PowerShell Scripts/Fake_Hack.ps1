# Fake Progress Bar with Changing Operation
$target = Read-Host 'Choose Your Target!'
Write-Host "Starting Hack On $target..."

for ($i = 0; $i -le 100; $i++) {

    # Change the activity message based on ranges of percentages
    if ($i -lt 5) {
        $activity = "Retrieving $target IP Address..."
    }
    elseif ($i -lt 15) {
        $activity = "Scanning $target For Open Ports..."
    }
    elseif ($i -lt 20) {
        $activity = "Connecting To $target..."
    }
    elseif ($i -lt 35) {
        $activity = "Running Privilege Escalation Attacks..."
    }
    elseif ($i -lt 40) {
        $activity = "Reconnecting As Administrator..."
    }
    elseif ($i -lt 50) {
        $activity = "Scanning Connected Hard Drives..."
    }
    elseif ($i -lt 70) {
        $activity = "Transfering Data To Local Device..."
    }
    elseif ($i -lt 75) {
        $activity = "Clearing Log Files..."
    }
    elseif ($i -lt 85) {
        $activity = "Reformatting All Hard Drives..."
    }
    elseif ($i -lt 100) {
        $activity = "Removing Online Footprint..."
    }

    else {
        $activity = "Hack On $target Has Been Completed!"
    }

    Write-Progress -Activity $activity -Status "$i% Complete" -PercentComplete $i
    Start-Sleep -Milliseconds 400  # Simulate work being done
}

# Completion message
Write-Host ""
Write-Host "$target Server Has Been Wiped! See C:\$target\HackedFiles\ To Retieve Gathered Information!" 
Write-Host ""
Read-Host -Prompt "Good Bye!"
