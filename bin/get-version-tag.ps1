if ((Get-Content $pwd\*.psd1 -Raw) -match "ModuleVersion\s+=\s+'(?<v>[\d.]+)'") {
    $manifestVersion = $Matches.v
    if ((git tag -l) -notcontains "$manifestVersion") {
        Write-Output $manifestVersion
    }
}
