REM Download latest installer
mkdir temp
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12; wget 'https://raw.githubusercontent.com/krokofant/lovely-powershell/master/Installer.ps1' -OutFile .\temp\Installer.ps1"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& .\temp\Installer.ps1"

REM PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& .\Installer.ps1"

pause

rmdir /S /Q temp