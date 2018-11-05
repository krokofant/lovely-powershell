PowerShell -NoProfile -ExecutionPolicy Bypass -Command "Set-ExecutionPolicy RemoteSigned -scope CurrentUser"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "iex (new-object net.webclient).downloadstring('https://get.scoop.sh')"
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "scoop install https://raw.githubusercontent.com/krokofant/lovely-powershell/master/lovelypowershell.json"

pause