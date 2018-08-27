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

# Hide username from prompt prefix
$DefaultUser = $env:USERNAME
$PrimaryTheme = "agnoster"
$SecondaryTheme = "sorin"


installIfMissing posh-git
installIfMissing oh-my-posh
installIfMissing Get-ChildItemColor

# Fix a oh-my-posh color issue
Set-PSReadlineOption -ResetTokenColors

# Prettier ls/l output
Set-Alias l Get-ChildItemColor -Option AllScope
Set-Alias ls Get-ChildItemColorFormatWide -Option AllScope

# Path shortcuts
Set-Alias ~ cdhome -Option AllScope

# Setup themes
Set-Theme $PrimaryTheme
function themePrimary { Set-Theme $PrimaryTheme }
function themeCode { Set-Theme $SecondaryTheme }
