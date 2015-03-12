# Ember-Cli-Windows-Setup
# This script configures Windows Deefender for Ember-Cli performance.
# (C) Copyright 2015 Microsoft, developed by Felix Rieseberg
# felix.rieseberg@microsoft.com

# ----------------------------------------------------------------------
# Usage: ./setup-defender.ps1 -path c:\mypath\*
# ----------------------------------------------------------------------

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string]$path
)

$tmpPath = $path
$tmpPath += "\tmp"

function Add-WindowsDefenderExclusionsPolicy([string]$pathToAdd)
{                  
    $registryKey = "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender\Exclusions\Paths" 
       
    $found = $False
    
    $items = Get-Item $registryKey
        
    Foreach ($name in $items.GetValueNames()) {
        if ([string]::Compare($name, $pathToAdd, $True) -eq 0) {
            # Path already added
            Write-Host "Path already added to exclusion list"
            return
        }
    }
            
    Set-ItemProperty -Path $registryKey -Name $pathToAdd -Value 0 -Force
    Write-Host "Path added to defender exclusion list, updating policy"
            
    gpupdate | Out-Null
}

function IsAdministrator
{
    $Identity = [System.Security.Principal.WindowsIdentity]::GetCurrent()
    $Principal = New-Object System.Security.Principal.WindowsPrincipal($Identity)
    $Principal.IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
}


function IsUacEnabled
{
    (Get-ItemProperty HKLM:\Software\Microsoft\Windows\CurrentVersion\Policies\System).EnableLua -ne 0
}

#
# Self-Elevate
#
if (!(IsAdministrator))
{
    if (IsUacEnabled)
    {
        [string[]]$argList = @('-NoProfile', '-NoExit', '-File', $MyInvocation.MyCommand.Path)
        $argList += $MyInvocation.BoundParameters.GetEnumerator() | Foreach {"-$($_.Key)", "$($_.Value)"}
        $argList += $MyInvocation.UnboundArguments
        Start-Process PowerShell.exe -Verb Runas -WorkingDirectory $pwd -ArgumentList $argList 
        return
    }
    else
    {
        throw "You must be administrator to run this script"
    }
}



# Set preference
"Removing " + $path + " from Windows Defender's Eye"


# https://msdn.microsoft.com/en-us/library/windows/desktop/ms724832%28v=vs.85%29.aspx
$version = [Environment]::OSVersion.Version

if ($version.Major -eq 6 -AND $version.Minor -gt 1) {
  # Windows 8 and above
  if (Get-Command Set-MpPreference -errorAction SilentlyContinue) {
    Set-MpPreference -ExclusionPath $path
  } else {
    "Defender Configuration not available, fallback required"
  }  
}
elseif ($version.Major -eq 6 -AND $version.Minor -eq 1) {
  # Windows 7 / Server 2008 R2
  Add-WindowsDefenderExclusionsPolicy $path
}

"Done"