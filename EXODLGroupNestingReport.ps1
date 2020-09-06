Write-Host "$(Get-Date)"

Function get-groupmembers($groupname, $iteration)
{
	$group = Get-DistributionGroup $groupname

		$members = $null
		$members = Get-DistributionGroupMember $group.name | Where { $_.RecipientType -Like "*group*" }
		
		if ($members)
		{
			if ($iteration -eq "0") { write-host -foregroundcolor yellow $group.name }
			++$iteration
			
			foreach ($member in $members)
			{
				for ($i = $iteration; $i -gt 0; $i--) { write-host "    " -nonewline }
				write-host "|"
				for ($i = $iteration; $i -gt 0; $i--) { write-host "    " -nonewline }
				write-host "+—-$member"
				get-groupmembers -groupname $member.name -iteration $iteration
			}
		}
}

#$groups = Get-DistributionGroup -ResultSize Unlimited
foreach ($group in $groups) { get-groupmembers -groupname $group.name -iteration 0 }

Write-Host "$(Get-Date)"