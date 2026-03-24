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
        # Simpan file secara paksa menggunakan UTF-8 Tanpa BOM
        [System.IO.File]::WriteAllText((Join-Path (Get-Location) $file), $response, $Utf8NoBomEncoding)
    } catch {
        Write-Host "Gagal API, menggunakan asli"
        [System.IO.File]::WriteAllText((Join-Path (Get-Location) $file), $content, $Utf8NoBomEncoding)
    }
}

Write-Host "Memastikan format UTF-8 untuk sisa file (manifest, html)..."
$otherFiles = @("manifest.json", "blocked.html", "popup.html")
foreach ($file in $otherFiles) {
    if (Test-Path $file) {
        $content = [System.IO.File]::ReadAllText((Join-Path (Get-Location) $file))
        [System.IO.File]::WriteAllText((Join-Path (Get-Location) $file), $content, $Utf8NoBomEncoding)
    }
}

Write-Host "2. Uploading ke GitHub..."
$git = "C:\Program Files\Git\cmd\git.exe"
& $git add .
& $git commit -m "Auto-fix: Merubah encoding semua file ke UTF-8 agar didukung oleh Chrome"
& $git push origin main

Write-Host "Selesai"
