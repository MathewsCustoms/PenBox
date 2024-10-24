# Fake Progress Bar with Changing Operation
$target = Read-Host 'Choose Your Target!'
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host ""
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor DarkCyan
Write-Host "         Starting Hack On $target..." -ForegroundColor Yellow
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor DarkCyan
Write-Host ""

for ($i = 0; $i -le 100; $i++) {

    # Change the activity message based on ranges of percentages
    if ($i -lt 3) {
        $activity = "Retrieving $target IP Address..."
    } 
    elseif ($i -lt 10) {
        $activity = "Scanning $target For Open Ports..."
    }
    elseif ($i -lt 14) {
        $activity = "Connecting To $target..."
    }
    elseif ($i -lt 29) {
        $activity = "Running Privilege Escalation Attacks..."
    }
    elseif ($i -lt 33) {
        $activity = "Reconnecting As Administrator..."
    }
    elseif ($i -lt 42) {
        $activity = "Scanning Connected Hard Drives..."
    }
    elseif ($i -lt 64) {
        $activity = "Transfering Data To Local Device..."
    }
    elseif ($i -lt 68) {
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
    Start-Sleep -Milliseconds 200  # Simulate work being done
}

# Completion message
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor DarkCyan
Write-Host "       $target Server Has Been Wiped!" -ForegroundColor Yellow
Write-Host "See C:\$target\HackedFiles\ To Retieve Files!" -ForegroundColor Yellow
Write-Host "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~" -ForegroundColor DarkCyan
Write-Host ""
Write-Host ""
Read-Host -Prompt "Good Bye!"
