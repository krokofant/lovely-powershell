# Workaround wget
$AllProtocols = [System.Net.SecurityProtocolType]'Ssl3,Tls,Tls11,Tls12'
[Net.ServicePointManager]::SecurityProtocol = $AllProtocols

# Install powerline fonts
New-Item lp-temp -ItemType Directory
wget -Headers @{"Cache-Control"="no-cache"} 'https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf?raw=true' -OutFile .\lp-temp\DejaVuSansMonoPowerLine.ttf
$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$objFolder.CopyHere($(Get-ChildItem .\lp-temp\DejaVuSansMonoPowerLine.ttf).FullName)
Remove-Item .\lp-temp -Force -Recurse