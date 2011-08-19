$temp_file = "$($env:Temp)\poshfiles.zip"

function New-Directory {
    param($dir)
    if ((Test-Path $dir)) {
        Resolve-Path $dir | Remove-Item -Recurse
    }
    New-Item $dir -Type Container
}

function Get-PoshfilesZip {
    (new-object Net.WebClient).DownloadFile("https://github.com/scottmuc/poshfiles/zipball/master", $temp_file)
}

function Unzip-PoshfilesZip {
    Resolve-Path $env:Temp\*-poshfiles-* | Remove-Item -Recurse

    $shell_app = new-object -com shell.application 
    $zip_file = $shell_app.namespace($temp_file) 
    $destination = $shell_app.namespace($env:Temp) 
    $destination.Copyhere($zip_file.items())

    New-Directory $env:UserProfile\poshfiles
    Resolve-Path $env:Temp\*-poshfiles-*\* | Copy-Item -Dest $env:UserProfile\poshfiles
}

function Install-Poshfiles {
    $profileDir = Split-Path $profile
    New-Directory $profileDir
    ". `$env:Userprofile\poshfiles\profile\profile.ps1" | Out-File $profile
}

Get-PoshfilesZip
Unzip-PoshfilesZip
Install-Poshfiles

"Custom poshfiles installed!" | Write-Host -Fore Green
