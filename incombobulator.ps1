param(
    [Parameter(Mandatory = $false)]
    [switch]$JesusTakeTheWheel = $false,

    [Parameter(Mandatory = $false)]
    [switch]$BelsebubMode = $false
)
if ($JesusTakeTheWheel) {
    $listAFile = "ordlister/adjektiv.txt"
}
if ($BelsebubMode) {
    $listAFile = "ordlister/svarteliste.txt"
}
else {
    $listAFile = "ordlister/clean-adjektiv.txt"
}

$listBFile = "ordlister/pokemon.txt"
$spentFile = "ordlister/tidligere-kombinasjoner.txt"

$listA = Get-Content $listAFile | Where-Object { $_ -ne "" }
$listB = Get-Content $listBFile | Where-Object { $_ -ne "" }

$spentSet = [System.Collections.Generic.HashSet[string]]@()
if (Test-Path $spentFile) {
    Get-Content $spentFile | Where-Object { $_ -ne "" } | ForEach-Object { $spentSet.Add($_) | Out-Null }
}

$totalPossible = $listA.Count * $listB.Count
if ($spentSet.Count -ge $totalPossible) {
    Write-Host "No combinations left! All possibilities have been spent." -ForegroundColor Red
    exit
}

do {
    $a = $listA | Get-Random
    $b = $listB | Get-Random
    $combo = "$a-$b"
} while ($spentSet.Contains($combo))

Write-Host "Generated combination: $combo" -ForegroundColor Green
Add-Content -Path $spentFile -Value $combo
Write-Host "Saved to '$spentFile'." -ForegroundColor DarkGray
