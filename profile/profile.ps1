function Setup-PowerShellAppPath {
    $env:Path = "$($env:Path);$($env:UserProfile)\poshfiles\apps"
}

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
   return ' ' 
}

function Edit-Hosts {
    Start-Process -FilePath notepad -ArgumentList "$env:windir\system32\drivers\etc\hosts"
}

function Import-InstalledModules {
    Get-Module -ListAvailable | ? { $_.ModuleType -eq "Script" } | Import-Module
}

Setup-Aliases
Setup-Filters
Setup-PowerShellAppPath
Import-InstalledModules

