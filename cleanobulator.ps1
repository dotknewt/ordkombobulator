# --- Configuration ---
$listAFile     = "ordlister\adjektiv.txt"
$blacklistFile = "svarteliste.txt"
$outputFile    = "ordlister\clean-adjektiv.txt"

# --- Load files ---
$listA     = Get-Content $listAFile | Where-Object { $_ -ne "" }
$blacklist = if (Test-Path $blacklistFile) { Get-Content $blacklistFile | Where-Object { $_ -ne "" } } else { @() }

# --- Filter and write ---
$listA | Where-Object { $_ -notin $blacklist } | Out-File -FilePath $outputFile -Encoding utf8

Write-Host "Done. Clean list written to '$outputFile'." -ForegroundColor Green
