$files = Get-ChildItem -Path "c:\Users\Administrator\Documents\pagarnet" -Include *.html,*.js,*.json -Recurse
foreach ($f in $files) {
    if ($f.Name -like "*.zip") { continue }
    $c = [System.IO.File]::ReadAllText($f.FullName)
    $c = $c.Replace("â€”", "-")
    $c = $c.Replace("â€“", "-")
    $c = $c.Replace("Â·", "·")
    $c = $c.Replace("â€œ", "`"")
    $c = $c.Replace("â€ ", "`"")
    $c = $c.Replace("â€¦", "...")
    $Utf8NoBom = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllText($f.FullName, $c, $Utf8NoBom)
}
Write-Host "Semua Mojibake telah dibersihkan!"
