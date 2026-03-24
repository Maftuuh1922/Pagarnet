$ErrorActionPreference = "Stop"

Write-Host "1. Mempersiapkan file .src.js untuk di-minify..."
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
        Write-Host "[!] Peringatan: Gagal meminifikasi $file. Menggunakan format sumber asli."
    }
}

Write-Host "2. Mendorong Update (Push) ke GitHub..."
$git = "C:\Program Files\Git\cmd\git.exe"
& $git add .
& $git commit -m "Update Deteksi: Tambal kebocoran iklan di situs Movie Streaming (Ibosport, dll)"
& $git push origin main

Write-Host "3. Update Selesai! Ekstensi di lokal maupun GitHub siap dipakai."
