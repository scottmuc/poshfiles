# found at http://www.gregorystrike.com/2011/01/27/how-to-tell-if-powershell-is-32-bit-or-64-bit/
function Get-Bits {
    Switch ([System.Runtime.InterOpServices.Marshal]::SizeOf([System.IntPtr])) {
        4 { Return "32-bit" }
        8 { Return "64-bit" }
        default { Return "Unknown Type" }
    }
}

