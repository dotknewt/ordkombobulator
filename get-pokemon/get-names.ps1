$headers = @{}
$response = Invoke-RestMethod 'https://pokeapi.co/api/v2/pokemon?limit=100000&offset=0' -Method 'GET' -Headers $headers

$names = $response.results | Select-Object -ExpandProperty name
$names | Out-File -FilePath "pokemon_names.txt" -Encoding utf8

Write-Host "Saved $($names.Count) Pokémon names to pokemon_names.txt"
