function Setup-Aliases {
    Set-Alias Power-Nap sleep
}

function Setup-Filters {
    filter grep($keyword) { if ( ($_ | Out-String) -like "*$keyword*") { $_ } }
}

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

Setup-Aliases
Setup-Filters
Setup-PowerShellAppPath
