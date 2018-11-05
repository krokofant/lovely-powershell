function installIfMissing {
  param
    (
        [string] $ModuleName
    )
    if (!(Get-Module -ListAvailable -Name $ModuleName)) {
      Write-Output "Installing missing module $ModuleName"
      Install-Module -Name $ModuleName -Scope CurrentUser
    }
}

$PrimaryTheme = "agnoster"
$SecondaryTheme = "sorin"


installIfMissing posh-git
installIfMissing oh-my-posh
installIfMissing Get-ChildItemColor

Import-Module posh-git
Import-Module oh-my-posh
Import-Module Get-ChildItemColor

# Fix a oh-my-posh color issue
Set-PSReadlineOption -ResetTokenColors

# Prettier ls/l output
Set-Alias -Scope Global l Get-ChildItemColor -Option AllScope
Set-Alias -Scope Global ls Get-ChildItemColorFormatWide -Option AllScope

# Path shortcuts
Set-Alias ~ cdhome -Option AllScope

# Setup themes
Set-Theme $PrimaryTheme
function themePrimary { Set-Theme $PrimaryTheme }
function themeCode { Set-Theme $SecondaryTheme }

function hackyInstall {
  param
    (
        [string] $ModuleName,
        [string] $ModuleUrl
    )
  [Net.ServicePointManager]::SecurityProtocol = "tls12, tls11, tls, Ssl3"
  wget -Headers @{"Cache-Control"="no-cache"} $ModuleUrl -OutFile "$(Split-Path $PROFILE)\$ModuleName.psm1"
}