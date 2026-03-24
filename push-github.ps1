$ErrorActionPreference = "Stop"

Write-Host "1. Mengamankan Source Code Asli..."
$filesToHide = @("background.js", "content.js", "popup.js")

foreach ($file in $filesToHide) {
    if (Test-Path $file) {
        # Hanya rename jika belum ada file .src.js (mencegah overwrite kalau dijalankan 2x)
        $srcName = $file.Replace(".js", ".src.js")
        if (!(Test-Path $srcName)) {
            Rename-Item $file $srcName -Force
        }
    }
}

Write-Host "2. Memasukkan Versi Protected..."
Copy-Item "Pagarnet-Protected\background.js" "background.js" -Force
Copy-Item "Pagarnet-Protected\content.js" "content.js" -Force
Copy-Item "Pagarnet-Protected\popup.js" "popup.js" -Force

Write-Host "3. Konfigurasi .gitignore untuk menyembunyikan source asli..."
$gitignore = @"
*.src.js
install-helper.cmd
install-helper.ps1
test-minify.ps1
build-protected.ps1
Pagarnet-Protected*/
*.zip
task.md
"@
Set-Content ".gitignore" -Value $gitignore -Force

Write-Host "4. Memperbaiki README.md (Menghapus referensi install lama)..."
$readme = Get-Content "README.md" -Raw
$patternToRemove = '(?s)### Install Cepat via CMD.*?\-\-\-\r?\n\r?\n'
$readmeStr = [regex]::Replace($readme, $patternToRemove, "")
Set-Content "README.md" -Value $readmeStr -Force

Write-Host "5. Menghapus riwayat Git lama dari folder lokal..."
if (Test-Path ".git") { Remove-Item ".git" -Recurse -Force -ErrorAction SilentlyContinue }
# Sometimes .git is locked or hidden. Use robust removal:
cmd.exe /c "rmdir /s /q .git"

Write-Host "6. Inisialisasi ulang Git & Push ke GitHub..."
git init
git add .
git config user.name "Maftuuh1922"
git config user.email "rizkiuya12gmail.com"
git commit -m "Release PagarNet Anti-Judol (Protected/Minified version)"
git branch -M main
git remote add origin https://github.com/Maftuuh1922/Pagarnet.git

Write-Host "Mengirim data ke GitHub... (Tunggu sebentar)"
git push -u origin main -f

Write-Host " "
Write-Host "==============================="
Write-Host "[OK] SUKSES! Repository GitHub berhasil diperbarui dengan versi terlindungi."
Write-Host "==============================="
