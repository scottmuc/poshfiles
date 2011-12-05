###########################################################
#
# Scott's custom profile
#
###########################################################

# prompt customization coming from the following:
# http://winterdom.com/2008/08/mypowershellprompt
function shorten-path([string] $path) { 
   $loc = $path.Replace($HOME, '~') 
   # remove prefix for UNC paths 
   $loc = $loc -replace '^[^:]+::', '' 
   # make path shorter like tabs in Vim, 
   # handle paths starting with \\ and . correctly 
   return ($loc -replace '\\(\.?)([^\\])[^\\]*(?=\\)','\$1$2') 
}

# This is function is called by convention in PowerShell
function prompt { 
   # our theme 
   $cdelim = [ConsoleColor]::DarkCyan 
   $chost = [ConsoleColor]::Green 
   $cloc = [ConsoleColor]::Cyan 

   write-host "$([char]0x0A7) " -n -f $cloc 
   write-host ([net.dns]::GetHostName()) -n -f $chost 
   write-host ' {' -n -f $cdelim 
   write-host (shorten-path (pwd).Path) -n -f $cloc 
   write-host '}' -n -f $cdelim 

   $global:GitStatus = Get-GitStatus
   Write-GitStatus $GitStatus

   return '> '
}

Set-Alias which Get-Command

function Setup-Path {
    $paths = @("$($env:Path)", "$($env:UserProfile)\poshfiles\scripts")
    gci $env:UserProfile\bin | % { $paths += $_.FullName }
    $env:Path = [String]::Join(";", $paths) 
}

function Import-InstalledModules {
    Get-Module -ListAvailable | ? { $_.ModuleType -eq "Script" } | Import-Module
}

function Nuke-Item($item) { Remove-Item $item -Recurse -Force }

function Edit-HostsFiles {
    Start-Process -FilePath notepad -ArgumentList "$env:windir\system32\drivers\etc\hosts"
}

# found at http://www.gregorystrike.com/2011/01/27/how-to-tell-if-powershell-is-32-bit-or-64-bit/
Function Get-Bits {
    Switch ([System.Runtime.InterOpServices.Marshal]::SizeOf([System.IntPtr])) {
        4 { Return "32-bit" }
        8 { Return "64-bit" }
        default { Return "Unknown Type" }
    }
}

Setup-Path
Import-InstalledModules

Enable-GitColors
