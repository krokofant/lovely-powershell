Import-Module PS-Install-If-Missing

$PrimaryTheme = "hitchens"
$SecondaryTheme = "sorin"
$DefaultUser = $env:USERNAME


Install-IfMissing posh-git
Install-IfMissing oh-my-posh
Install-IfMissing Get-ChildItemColor

Import-Module -Global posh-git
Import-Module -Global oh-my-posh
Import-Module -Global Get-ChildItemColor

# Prettier ls/l output
Set-Alias -Scope Global l Get-ChildItemColor -Option AllScope
Set-Alias -Scope Global ls Get-ChildItemColorFormatWide -Option AllScope

# Setup themes
$Global:ThemeSettings.MyThemesLocation = Join-Path $PSScriptRoot "PoshThemes"
Set-Theme $PrimaryTheme
function themePrimary { Set-Theme $PrimaryTheme }
function themeCode { Set-Theme $SecondaryTheme }

Export-ModuleMember -Function @(
  'Set-Theme'
) -Alias @(
  '~'
) -Variable @(
  'DefaultUser'
)
