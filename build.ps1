# Activate Emscripten environment
$emsdk_path = "$env:USERPROFILE\.emsdk"

Write-Host "Activating Emscripten from $emsdk_path"
Push-Location $emsdk_path
./emsdk activate latest
. ./emsdk_env.ps1
Pop-Location

$cmake_path="C:\Program Files\Microsoft Visual Studio\2022\Preview\Common7\IDE\CommonExtensions\Microsoft\CMake\CMake\bin\cmake.exe"
# Set proper environment variables for Emscripten
$env:EMSCRIPTEN = "$emsdk_path\upstream\emscripten"
$env:PATH = "$env:EMSCRIPTEN;$env:PATH"
$env:EMCC = "$env:EMSCRIPTEN\emcc.bat"

& emcmake $cmake_path -B build -S .
if ($LASTEXITCODE -ne 0) {
    Write-Error "Cmake failed"
    exit 1
}

& emmake $cmake_path --build build

if ($LASTEXITCODE -ne 0) {
    Write-Error "Build failed"
    exit 1
}

Write-Host "Build completed successfully!"
