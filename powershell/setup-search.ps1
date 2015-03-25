# Ember-Cli-Windows-Setup
# This script configures Windows Search for Ember-Cli performance.
# (C) Copyright 2015 Microsoft, developed by Felix Rieseberg
# felix.rieseberg@microsoft.com

# ----------------------------------------------------------------------
# Usage: ./setup-search.ps1 -path c:\mypath\*
# ----------------------------------------------------------------------

[CmdletBinding()]
Param(
    [Parameter(Mandatory=$True)]
    [string]$path
)

function Get-ScriptDirectory
{
    Split-Path $script:MyInvocation.MyCommand.Path
}

# Powershell 2 and below didn't have $PSScriptRoot variable
# and so we must obtain script directory differently in that case
if(!$PSScriptRoot) {
    $PSScriptRoot = Get-ScriptDirectory
}

$tmpPath = "file:///"
$tmpPath += $path
$tmpPath += "\tmp\*"

"Removing " + $tmpPath + " from Search Index"

# Load DLL, get SearchManagerClass
Add-Type -Path (Join-Path $PSScriptRoot "Microsoft.Search.Interop.dll")

$sm = New-Object Microsoft.Search.Interop.CSearchManagerClass 
$catalog = $sm.GetCatalog("SystemIndex")
$crawlman = $catalog.GetCrawlScopeManager()

# Add Folders to Rules
$crawlman.AddUserScopeRule($tmpPath,$false,$false,$null)
$crawlman.SaveAll()

"Done"