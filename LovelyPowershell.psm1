Import-Module PS-Install-If-Missing

$LovelyThemesFolder = Join-Path $PSScriptRoot "PoshThemes"
$HitchensTheme = Join-Path $LovelyThemesFolder "Hitchens.psm1"
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

Set-Theme $HitchensTheme

Export-ModuleMember -Function @(
) -Alias @(
  'l',
  'ls'
) -Variable @(
  'DefaultUser'
)
