# Activate Emscripten environment
$emsdk_path = "$env:USERPROFILE\.emsdk"

Write-Host "Activating Emscripten from $emsdk_path"
Push-Location $emsdk_path
./emsdk activate latest
. ./emsdk_env.ps1
Pop-Location

& python -m http.server --directory build 8000