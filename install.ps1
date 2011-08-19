$temp_file = "$($env:Temp)\poshfiles.zip"

function Get-PoshfilesZip {
    param ($file)
    if (Test-Path $file) {
        Remove-Item $file | Out-Null
    }
    "Downloading poshfiles from github" | Write-Host
    (new-object Net.WebClient).DownloadFile("https://github.com/scottmuc/poshfiles/zipball/master", $file)
}

function Unzip-PoshfilesZip {
    Resolve-Path $env:Temp\*-poshfiles-* | Remove-Item -Recurse

    "Extracting poshfiles" | Write-Host
    $shell_app = new-object -com shell.application 
    $zip_file = $shell_app.namespace($temp_file) 
    $destination = $shell_app.namespace($env:Temp) 
    $destination.Copyhere($zip_file.items())

    if ((Test-Path $env:UserProfile\poshfiles)) {
        Resolve-Path  $env:UserProfile\poshfiles | Remove-Item -Recurse
    }

    New-Item  $env:UserProfile\poshfiles -Type Container | Out-Null
    $unzip_dir = (Resolve-Path $env:Temp\*-poshfiles-* ).Path
    Copy-Item $unzip_dir\* -Dest $env:UserProfile\poshfiles -Recurse
}

function Setup-Profile {
    $profile_dir = Split-Path $profile
    if (-not (Test-Path $profile_dir)) {
        New-Item $profile_dir -Type Container | Out-Null
    }
    "Setting up profile" | Write-Host
    ". `$env:Userprofile\poshfiles\profile\profile.ps1" | Out-File $profile
}

Get-PoshfilesZip $temp_file
Unzip-PoshfilesZip
Setup-Profile

. $profile
"Custom poshfiles installed!" | Write-Host -Fore Green
