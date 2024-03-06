# URL of the executable file to download
$exeUrl = "https://example.com/path/to/your/file.exe"

# File path where the executable will be saved
$exeFilePath = "$env:USERPROFILE\Downloads\file.exe"

# Download the executable file
Invoke-WebRequest -Uri $exeUrl -OutFile $exeFilePath

# Run the executable file silently
Start-Process -FilePath $exeFilePath -WindowStyle Hidden
