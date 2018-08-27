REM Download latest installer
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& wget 'https://raw.githubusercontent.com/krokofant/lovely-powershell/master/Installer.ps1' -OutFile .\temp\Installer.ps1"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& .\temp\Installer.ps1"

REM PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& .\Installer.ps1"

pause
