$profileDir = Split-Path $profile

if (-not (Test-Path $profileDir)) {
    New-Item $profileDir -Type Container
}

". `$env:Userprofile\poshfiles\profile\profile.ps1" | Out-File $profile
