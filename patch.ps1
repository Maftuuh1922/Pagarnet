$ErrorActionPreference = "Stop"

Write-Host "1. Mempersiapkan update core background..."
Copy-Item "background.src.js" "background.js" -Force
Copy-Item "content.src.js" "content.js" -Force
Copy-Item "popup.src.js" "popup.js" -Force

$jsFiles = @("background.js", "content.js", "popup.js")
foreach ($file in $jsFiles) {
    Write-Host "Mengacak/Minify $file..."
    $content = Get-Content -Path $file -Raw
    try {
        $response = Invoke-RestMethod -Uri "https://www.toptal.com/developers/javascript-minifier/api/raw" -Method Post -Body @{ input = $content }
        Set-Content -Path $file -Value $response -Force
    } catch {
        Write-Host "Gagal API meminifikasi $file, biarkan."
    }
}

Write-Host "2. Uploading ke GitHub..."
$git = "C:\Program Files\Git\cmd\git.exe"
& $git add .
& $git commit -m "Patch: Blokir akses domain Dewasport dan web taruhan bola"
& $git push origin main

Write-Host "Selesai"
