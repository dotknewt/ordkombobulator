# --- Configuration ---
$listAFile = "ordlister\clean-adjektiv.txt"
$listBFile = "ordlister\pokemon.txt"
$spentFile = "excluded-combinations.txt"

# --- Load lists from disk ---
$listA = Get-Content $listAFile | Where-Object { $_ -ne "" }
$listB = Get-Content $listBFile | Where-Object { $_ -ne "" }

# --- Load spent combinations into a HashSet for fast lookup ---
$spentSet = [System.Collections.Generic.HashSet[string]]@()
if (Test-Path $spentFile) {
    Get-Content $spentFile | Where-Object { $_ -ne "" } | ForEach-Object { $spentSet.Add($_) | Out-Null }
}

# --- Check if all combinations are exhausted ---
$totalPossible = $listA.Count * $listB.Count
if ($spentSet.Count -ge $totalPossible) {
    Write-Host "No combinations left! All possibilities have been spent." -ForegroundColor Red
    exit
}

# --- Pick a random unused combination ---
do {
    $a = $listA | Get-Random
    $b = $listB | Get-Random
    $combo = "$a-$b"
} while ($spentSet.Contains($combo))

# --- Output and save ---
Write-Host "Generated combination: $combo" -ForegroundColor Green
Add-Content -Path $spentFile -Value $combo
Write-Host "Saved to '$spentFile'." -ForegroundColor DarkGray
