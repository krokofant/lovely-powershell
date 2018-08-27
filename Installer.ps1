$powershellRoot = $(Split-Path $PROFILE)

# As admin
Start-Process powershell.exe -Verb Runas -ArgumentList "-Command & 'Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Force'"
# As user
Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
# As admin
Start-Process powershell.exe -Verb Runas -ArgumentList "-Command & 'Install-Module -Name PowerShellGet -Force'"

# Install powerline fonts
wget 'https://github.com/powerline/fonts/blob/master/DejaVuSansMono/DejaVu%20Sans%20Mono%20for%20Powerline.ttf?raw=true' -OutFile .\temp\DejaVuSansMonoPowerLine.ttf
$FONTS = 0x14
$objShell = New-Object -ComObject Shell.Application
$objFolder = $objShell.Namespace($FONTS)
$objFolder.CopyHere($(Get-ChildItem .\temp\DejaVuSansMonoPowerLine.ttf).FullName)

# Install profile
wget 'https://raw.githubusercontent.com/krokofant/lovely-powershell/master/Microsoft.PowerShell_profile.ps1' -OutFile .\temp\Microsoft.PowerShell_profile.ps1
Copy-Item .\temp\Microsoft.PowerShell_profile.ps1 $PROFILE
Unblock-File $PROFILE

# Install LovelyShell
wget 'https://raw.githubusercontent.com/krokofant/lovely-powershell/master/LovelyShell.psm1' -OutFile "$powershellRoot\LovelyShell.psm1"

# Install scoop package manager
iex (new-object net.webclient).downloadstring('https://get.scoop.sh')

# Config themes
scoop install concfg
concfg import 'https://gist.githubusercontent.com/krokofant/bddff344478fcc22c89978f5cd152dc8/raw/ce075289536522e0c304287fb12d6cc5d615a875/ashes-custom.json'
