<#
.SYNOPSIS
    Imports data from your Excel CSV file into SharePoint
.DESCRIPTION
    Use an Excel CSV file to pull data into your SharePoint lists. This script can be scheduled to automate 
	importing new data as CSVs are created.
	See blog post at http://wp.me/p1H6Zd-40 for more information on how to use it.
.NOTES
    Author: David Lozzi @DavidLozzi
    DateCreated: 12Jan2012
#>

if((Get-PSSnapin | Where {$_.Name -eq “Microsoft.SharePoint.PowerShell”}) -eq $null) {
	Add-PSSnapin Microsoft.SharePoint.PowerShell
}
$web = Get-SPWeb https://apps.ab21.org/trackerbase

$list = $web.lists["OfficeSubscribers"]

$cnt = 0
foreach($i in Import-CSV \\ambridge1\users\dormsby\Desktop\office_list.csv)
{
    $new = $list.Items.Add()
    $new["Office"] = $i.Office
    $new.Update()
    $cnt++
}
"Added " + $cnt.ToString() + " records."

"Done. Press any key to continue..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
