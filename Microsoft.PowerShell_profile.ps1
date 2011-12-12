###########################################################
#
# Scott's custom profile
#
###########################################################

# ahh yes... this would be so nice if it was a built in variable
$here = Split-Path -Parent $MyInvocation.MyCommand.Path

# load all script modules available to us
Get-Module -ListAvailable | ? { $_.ModuleType -eq "Script" } | Import-Module

# function loader
#
# if you want to add functions you can added scripts to your
# powershell profile functions directory or you can inline them
# in this file. Ignoring the dot source of any tests
Resolve-Path $here\functions\*.ps1 | 
? { -not ($_.ProviderPath.Contains(".Tests.")) } |
% { . $_.ProviderPath }

# inline functions, aliases and variables
function which($name) { Get-Command $name | Select-Object Definition }
function rm-rf($item) { Remove-Item $item -Recurse -Force }
function touch($file) { "" | Out-File $file -Encoding ASCII }
Set-Alias g gvim
$TransientScriptDir = "$here\scripts"
$UserBinDir = "$($env:UserProfile)\bin"

# PATH update
#
# creates paths to every subdirectory of userprofile\bin
# adds a transient script dir that I use for experiments
$paths = @("$($env:Path)", $TransientScriptDir)
gci $UserBinDir | % { $paths += $_.FullName }
$env:Path = [String]::Join(";", $paths) 
