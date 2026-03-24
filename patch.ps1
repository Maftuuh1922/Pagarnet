$ErrorActionPreference = "Stop"

Write-Host "1. Mempersiapkan update core background..."
Copy-Item "background.src.js" "background.js" -Force
Copy-Item "content.src.js" "content.js" -Force
Copy-Item "popup.src.js" "popup.js" -Force

$jsFiles = @("background.js", "content.js", "popup.js")
$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False

foreach ($file in $jsFiles) {
    Write-Host "Mengacak/Minify $file..."
    $content = Get-Content -Path $file -Raw
    try {
        $response = Invoke-RestMethod -Uri "https://www.toptal.com/developers/javascript-minifier/api/raw" -Method Post -Body @{ input = $content }
        [System.IO.File]::WriteAllText((Join-Path (Get-Location) $file), $response, $Utf8NoBomEncoding)
    } catch {
        [System.IO.File]::WriteAllText((Join-Path (Get-Location) $file), $content, $Utf8NoBomEncoding)
    }
}

Write-Host "2. Uploading ke GitHub..."
$git = "C:\Program Files\Git\cmd\git.exe"
& $git add .
& $git commit -m "Patch: General Vision ML - Blokir mutlak banner panorama ekstrem di segala situasi"
& $git push origin main

Write-Host "Selesai"
