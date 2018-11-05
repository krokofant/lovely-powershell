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
$DefaultUser = $env:USERNAME


installIfMissing posh-git
installIfMissing oh-my-posh
installIfMissing Get-ChildItemColor

Import-Module -Global posh-git
Import-Module -Global oh-my-posh
Import-Module -Global Get-ChildItemColor

# Fix a oh-my-posh color issue
Set-PSReadlineOption -ResetTokenColors

# Prettier ls/l output
Set-Alias -Scope Global l Get-ChildItemColor -Option AllScope
Set-Alias -Scope Global ls Get-ChildItemColorFormatWide -Option AllScope

# Setup themes
Set-Theme $PrimaryTheme
function themePrimary { Set-Theme $PrimaryTheme }
function themeCode { Set-Theme $SecondaryTheme }

Export-ModuleMember -Function @(
  'themePrimary',
  'themeCode',
  'installIfMissing'
) -Alias @(
  '~'
) -Variable @(
  'DefaultUser'
)