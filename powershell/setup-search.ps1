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
$crawlman.AddUserScopeRule($tmpPath,$false,$true,$null)
$crawlman.SaveAll()

"Done"